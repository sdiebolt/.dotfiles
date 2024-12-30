return {
    "catppuccin/nvim",

    lazy = false,

    name = "catppuccin",

    priority = 1000,

    config = function()
        require("catppuccin").setup({
            integrations = {
                beacon = true,
                fidget = true,
                noice = true,
                notifier = true,
                snacks = true,
                lsp_trouble = true,
                harpoon = true,
                mason = true,
                which_key = true
            },
        })

        vim.cmd([[colorscheme catppuccin-mocha]])
    end
}
