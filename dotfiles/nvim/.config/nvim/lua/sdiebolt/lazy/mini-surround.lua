return {
    "echasnovski/mini.surround",

    event = "VeryLazy",

    version = "*",

    opts = {
        mappings = {
            add = "sa",          -- Add surroundng in Normal and Visual modes
            delete = "sd",       -- Delete surrounding
            find = "sf",         -- Find surrounding (to the right)
            find_left = "sF",    -- Find surrounding (to the left)
            highlight = "sh",    -- Highlight surrounding
            replace = "sr",      -- Replace surrounding
            update_n_lines = "", -- Update surrounding for n lines
        },
        n_lines = 100,
    },
}
