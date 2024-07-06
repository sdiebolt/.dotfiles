return {
    "nvim-neo-tree/neo-tree.nvim",

    branch = "v3.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
    },

    keys = {
        {"<leader>nt" , "<Cmd>Neotree toggle<CR>", desc = "Neotree: toggle" },
        {"<leader>np" , "<Cmd>Neotree position=current<CR>", desc = "Neotree: full"},
    },
}
