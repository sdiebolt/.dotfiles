return {
    "catppuccin/nvim",

    lazy = false,

    name = "catppuccin",

    priority = 1000,

    config = function()
        require("catppuccin").setup({
            integrations = {
                beacon = true,
                blink_cmp = true,
                copilot_vim = true,
                dap = true,
                dap_ui = true,
                fidget = true,
                flash = true,
                harpoon = true,
                gitsigns = true,
                lsp_trouble = true,
                mason = true,
                neotree = true,
                noice = true,
                notify = true,
                snacks = {
                    enabled = false,
                    indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                },
                which_key = true,
            },
        })

        vim.cmd([[colorscheme catppuccin-mocha]])
    end
}
