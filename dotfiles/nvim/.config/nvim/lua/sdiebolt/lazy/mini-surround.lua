return {
    "echasnovski/mini.surround",

    event = "VeryLazy",

    version = "*",

    opts = {
        mappings = {
            add = "<leader>sa",       -- Add surroundng in Normal and Visual modes
            delete = "<leader>sd",    -- Delete surrounding
            find = "<leader>sf",      -- Find surrounding (to the right)
            find_left = "<leader>sF", -- Find surrounding (to the left)
            highlight = "<leader>sh", -- Highlight surrounding
            replace = "<leader>sr",   -- Replace surrounding
            update_n_lines = "",      -- Update surrounding for n lines
        },
        n_lines = 100,
    },
}
