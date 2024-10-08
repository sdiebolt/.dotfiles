return {
    "VonHeikemen/lsp-zero.nvim",

    branch = "v3.x",

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
        local lsp_zero = require("lsp-zero")

        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

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

        require("fidget").setup({})
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "basedpyright",
                "lua_ls",
                "ruff",
                "matlab_ls",
                "tinymist",
            },
            handlers = {
                lsp_zero.default_setup,
                rust_analyzer = function()
                    require("lspconfig").rust_analyzer.setup({
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
                        settings = {
                            basedpyright = {
                                -- Using Ruff"s import organizer.
                                disableOrganizeImports = true,
                                -- I use too many packages that don't have stubs.
                                typeCheckingMode = "off",
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
                matlab_ls = function()
                    require("lspconfig").matlab_ls.setup({
                        filetypes = { "matlab" },
                        settings = {
                            matlab = {
                                installPath = "/usr/local/MATLAB/R2022a",
                            },
                        },
                        single_file_support = true,
                    })
                end,
                tinymist = function()
                    require("lspconfig").tinymist.setup({
                        single_file_support = true,
                        root_dir = function()
                            return vim.fn.getcwd()
                        end,
                        settings = {
                            formatterMode = "typstyle",
                        },
                    })
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
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete({}),
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
