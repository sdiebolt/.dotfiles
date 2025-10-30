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
                        command = { "uv", "run", "ipython", "--no-autoindent" },
                        format = require("iron.fts.common").bracketed_paste_python,
                    },
                },
                repl_open_cmd = require("iron.view").split.belowright("20%"),
            },

            keymaps = {
                send_motion = "<leader>is",
                visual_send = "<leader>is",
                send_file = "<leader>if",
                send_line = "<leader>il",
                send_paragraph = "<leader>ip",
                send_until_cursor = "<leader>iu",
                send_mark = "<leader>iS",
                mark_motion = "<leader>im",
                mark_visual = "<leader>im",
                remove_mark = "<leader>id",
                cr = "<leader>i<cr>",
                interrupt = "<leader>ic",
                exit = "<leader>iq",
                clear = "<leader>il",
            },
            highlight = {
                italic = true
            },
            ignore_blank_lines = true,
        }
    end,

    keys = {
        { "<leader>ir", "<cmd>IronRepl<cr>",    desc = "Iron: open REPL" },
        { "<leader>iR", "<cmd>IronRestart<cr>", desc = "Iron: restart REPL" },
        { "<leader>ii", "<cmd>IronFocus<cr>",   desc = "Iron: focus REPL" },
        { "<leader>ih", "<cmd>IronHide<cr>",    desc = "Iron: hide REPL" },
    }
}
