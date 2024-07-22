return {
    "Vigemus/iron.nvim",

    config = function()
        local iron = require("iron.core")

        iron.setup {
            config = {
                scratch_repl = true,

                repl_definition = {
                    sh = {
                        command = { "zsh" },
                    },
                    python = {
                        command = { "ipython", "--no-autoindent" },
                        format = require("iron.fts.common").bracketed_paste_python,
                    },
                },
                repl_open_cmd = require("iron.view").split.belowright("20%"),
            },

            keymaps = {
                send_motion = "<leader>sc",
                visual_send = "<leader>sc",
                send_file = "<leader>sf",
                send_line = "<leader>sl",
                send_paragraph = "<leader>sp",
                send_until_cursor = "<leader>su",
                send_mark = "<leader>sm",
                mark_motion = "<leader>mc",
                mark_visual = "<leader>mc",
                remove_mark = "<leader>md",
                cr = "<leader>s<cr>",
                interrupt = "<leader>s<space>",
                exit = "<leader>sq",
                clear = "<leader>cl",
            },
            highlight = {
                italic = true
            },
            ignore_blank_lines = true,
        }
    end,
    keys = {
        { "<leader>rs", "<cmd>IronRepl<cr>",    desc = "Iron: open REPL" },
        { "<leader>rr", "<cmd>IronRestart<cr>", desc = "Iron: restart REPL" },
        { "<leader>rf", "<cmd>IronFocus<cr>",   desc = "Iron: focus REPL" },
        { "<leader>rh", "<cmd>IronHide<cr>",    desc = "Iron: hide REPL" },
    }
}
