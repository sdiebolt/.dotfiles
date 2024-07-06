return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = { "nvim-lua/plenary.nvim" },

    opts = {},

    keys = function()
        local builtin = require("telescope.builtin")

        return {
            { "<leader>ff", builtin.find_files, desc = "Telescope: files" },
            { "<leader>fp", builtin.git_files,  desc = "Telescope: git" },
            { "<leader>fg", builtin.live_grep,  desc = "Telescope: grep" },
            { "<leader>fb", builtin.buffers,    desc = "Telescope: buffers" },
        }
    end,
}
