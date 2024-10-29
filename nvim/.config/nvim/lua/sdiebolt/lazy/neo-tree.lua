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
        { "<leader>nt", "<Cmd>Neotree position=right toggle reveal<CR>",   desc = "Neotree: sidebar" },
        { "<leader>np", "<Cmd>Neotree position=current toggle reveal<CR>", desc = "Neotree: full" },
    },

    opts = {
        buffers = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
            group_empty_dirs = true,
            show_unloaded = true,
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                    ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
                    ["oc"] = { "order_by_created", nowait = false },
                    ["od"] = { "order_by_diagnostics", nowait = false },
                    ["om"] = { "order_by_modified", nowait = false },
                    ["on"] = { "order_by_name", nowait = false },
                    ["os"] = { "order_by_size", nowait = false },
                    ["ot"] = { "order_by_type", nowait = false },
                }
            },
        },
    }
}
