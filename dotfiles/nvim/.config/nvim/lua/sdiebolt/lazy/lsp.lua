return {
    "VonHeikemen/lsp-zero.nvim",

    branch = "v4.x",

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        -- Disable LSP logging, as the LSP log file will otherwise grow indefinitely.
        -- To enable logging, set the log level to "debug" when debugging LSP issues.
        vim.lsp.set_log_level("off")

        local lsp_zero = require("lsp-zero")

        local lsp_attach = function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })
        end

        local border = "single"

        lsp_zero.extend_lspconfig({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            lsp_attach = lsp_attach,
            float_border = border,
            sign_text = true,
        })

        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["rust_analyzer"] = { "rust" },
                ["ruff"] = { "python" },
                ["texlab"] = { "tex", "plaintex", "bib" },
                ["lua_ls"] = { "lua" },
                ["tinymist"] = { "typst" },
            }
        })

        -- Add border to the diagnostic popup window
        vim.diagnostic.config({
            virtual_text = {
                prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
            },
            float = { border = border },
        })

        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        }

        require("fidget").setup({})
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "basedpyright",
                "lua_ls",
                "ruff",
                "tinymist",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({ handlers = handlers })
                end,
                rust_analyzer = function()
                    require("lspconfig").rust_analyzer.setup({
                        handlers = handlers,
                        on_attach = function(client, bufnr)
                            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                        end,
                        settings = {
                            ["rust-analyzer"] = {
                                checkOnSave = {
                                    command = "clippy",
                                },
                                procMacro = {
                                    enable = true,
                                },
                            },
                        },
                    })
                end,
                ruff = function()
                    require("lspconfig").ruff.setup {
                        handlers = handlers,
                        on_attach = function(client, bufnr)
                            -- Disable hover in favor of Pyright
                            client.server_capabilities.hoverProvider = false

                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.buf.code_action({
                                        context = { only = { "source.organizeImports.ruff" } },
                                        apply = true,
                                    })
                                    vim.wait(100)
                                end,
                            })
                        end
                    }
                end,
                basedpyright = function()
                    require("lspconfig").basedpyright.setup({
                        handlers = handlers,
                        settings = {
                            basedpyright = {
                                -- Using Ruff"s import organizer.
                                disableOrganizeImports = true,
                                -- I use too many packages that don"t have stubs.
                                typeCheckingMode = "basic",
                            },
                            python = {
                                analysis = {
                                    -- Ignore all files for analysis to exclusively use
                                    -- Ruff for linting.
                                    ignore = { "*" },
                                },
                            },
                        },
                    })
                end,
                tinymist = function()
                    require("lspconfig").tinymist.setup({
                        handlers = handlers,
                        single_file_support = true,
                        root_dir = function()
                            return vim.fn.getcwd()
                        end,
                        settings = {
                            formatterMode = "typstyle",
                            preview = {
                                pinPreviewFalse = false,
                            }
                        },
                    })

                    vim.api.nvim_create_user_command("TypstPin", function()
                        local tinymist_id = nil
                        for _, client in pairs(vim.lsp.get_clients()) do
                            if client.name == "tinymist" then
                                tinymist_id = client.id
                                break
                            end
                        end

                        if not tinymist_id then
                            vim.notify("Tinymist not running!", vim.log.levels.ERROR)
                            return
                        end

                        local client = vim.lsp.get_client_by_id(tinymist_id)
                        if client then
                            client.request("workspace/executeCommand", {
                                command = "tinymist.pinMain",
                                arguments = { vim.api.nvim_buf_get_name(0) },
                            }, function(err)
                                if err then
                                    vim.notify("Error pinning: " .. err, vim.log.levels.ERROR)
                                else
                                    vim.notify("Succesfully pinned!", vim.log.levels.INFO)
                                end
                            end, 0)
                        end
                    end, {})
                end,
            },
        })

        local cmp = require("cmp")
        cmp.setup({
            sources = {
                { name = "nvim_lsp", group_index = 1 },
                { name = "path",     group_index = 1 },
                { name = "buffer",   group_index = 2 },
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete({}),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "path", group_index = 1 },
                {
                    name = "cmdline",
                    option = { ignore_cmds = { "Man", "!" } },
                    group_index = 2
                }
            }
        })
    end
}
