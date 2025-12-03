return {
    "MeanderingProgrammer/render-markdown.nvim",

    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
        completions = { 
            blink = { enabled = false },
            lsp = { enabled = true } 
        },
    },
}
