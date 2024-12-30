return {
    "linux-cultist/venv-selector.nvim",

    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python",
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
    },

    lazy = false,

    branch = "regexp",

    keys = {
        { "<leader>vv", "<cmd>VenvSelect<cr>" },
    },

    opts = {},
}
