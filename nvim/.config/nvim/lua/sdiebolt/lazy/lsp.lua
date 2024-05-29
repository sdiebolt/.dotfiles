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
            lsp_zero.default_keymaps({buffer = bufnr})
        end)

        require("fidget").setup({})
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "rust_analyzer", "pyright", "lua_ls" },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            },
        })

        local cmp = require("cmp")
        cmp.setup({
            sources = {
                { name = "nvim_lsp", group_index = 1 },
                { name = "path", group_index = 1 },
                { name = "buffer", group_index = 2 },
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete({ }),
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
