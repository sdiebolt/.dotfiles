return {
    "folke/snacks.nvim",

    priority = 1000,

    lazy = false,

    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },

        dashboard = {
            enabled = true,
            preset = {
                header = table.concat({
                    "██████╗  █████╗  ██████╗██╗  ██╗     █████╗ ████████╗    ██╗████████╗    ███████╗ █████╗ ███╗   ███╗██╗   ██╗███████╗██╗     ",
                    "██╔══██╗██╔══██╗██╔════╝██║ ██╔╝    ██╔══██╗╚══██╔══╝    ██║╚══██╔══╝    ██╔════╝██╔══██╗████╗ ████║██║   ██║██╔════╝██║     ",
                    "██████╔╝███████║██║     █████╔╝     ███████║   ██║       ██║   ██║       ███████╗███████║██╔████╔██║██║   ██║█████╗  ██║     ",
                    "██╔══██╗██╔══██║██║     ██╔═██╗     ██╔══██║   ██║       ██║   ██║       ╚════██║██╔══██║██║╚██╔╝██║██║   ██║██╔══╝  ██║     ",
                    "██████╔╝██║  ██║╚██████╗██║  ██╗    ██║  ██║   ██║       ██║   ██║▄█╗    ███████║██║  ██║██║ ╚═╝ ██║╚██████╔╝███████╗███████╗",
                    "╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝  ╚═╝   ╚═╝       ╚═╝   ╚═╝╚═╝    ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚══════╝\n",
                }, "\n"),
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 4, padding = 1 },
                { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 4, padding = 1 },
                { section = "startup" },
            },
        },

        notifier = {
            enabled = true,
            timeout = 3000,
        },

        quickfile = { enabled = true },

        statuscolumn = { enabled = true },

        words = { enabled = true },

        styles = {
            notification = {
                wo = { wrap = true } -- Wrap notifications
            }
        }
    },

    keys = {
        { "<leader>Nu", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<leader>Ns", function() Snacks.notifier.show_history() end,   desc = "Show All Notifications" },
        { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
        { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
        { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
        { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
        { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
        { "<c-_>",      function() Snacks.terminal.toggle("zsh") end,    desc = "Toggle Terminal" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference" },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    },

    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
            end,
        })
    end,
}
