return {
    "folke/snacks.nvim",

    priority = 1000,

    lazy = false,

    ---@type snacks.Config
    opts = {
        animate = { enabled = true },
        bigfile = { enabled = true },
        dashboard = {
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
        explorer = { replace_netrw = true },
        gh = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        image = { enabled = true },
        notifier = { timeout = 3000 },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scratch = { enabled = true },
        statuscolumn = { enabled = true },
        styles = {
            notification = {
                wo = { wrap = true } -- Wrap notifications
            }
        },
        terminal = { enabled = true },
        toggle = { enabled = true },
        words = { enabled = true },
    },

    keys = {
        -- Top pickers & explorers
        { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command history" },
        { "<leader>nh",      function() Snacks.picker.notifications() end,                           desc = "[n]otification [h]istory" },
        { "<leader>nd",      function() Snacks.notifier.hide() end,                                  desc = "[n]otification [d]ismiss" },
        { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File [e]xplorer" },

        -- find
        { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "[f]ind: [b]uffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[f]ind: [c]onfig file" },
        { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "[f]ind: [f]iles" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "[f]ind: [g]it files" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "[f]ind: [p]rojects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "[f]ind: [r]ecent" },

        -- git
        { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "[g]it: [b]ranches" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "[g]it: [l]og" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "[g]it: [L]og line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "[g]it: [s]tatus" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "[g]it: [S]tash" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "[g]it: [d]iff (hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "[g]it: [l]og File" },
        { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "[g]it: lazy[g]it" },

        -- gh
        { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "[g]it: GitHub [i]ssues (open)" },
        { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "[g]it: GitHub [I]ssues (all)" },
        { "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "[g]it: GitHub pull [r]equests (open)" },
        { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "[g]it: GitHub pull [R]equests (all)" },
        { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "[g]it: GitHub [B]rowse",               mode = { "n", "v" } },

        -- search
        { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "[s]earch: registers" },
        { "<leader>s/",      function() Snacks.picker.search_history() end,                          desc = "[s]earch: history" },
        { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "[s]earch: [b]uffer lines" },
        { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "[s]earch: [a]utocmds" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "[s]earch: [g]rep" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "[s]earch: grep open [B]uffers" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "[s]earch: visual selection or [w]ord", mode = { "n", "x" } },
        { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "[s]earch: [c]ommand history" },
        { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "[s]earch: [C]ommands" },
        { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "[s]earch: [d]iagnostics" },
        { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "[s]earch: buffer [D]iagnostics" },
        { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "[s]earch: [h]elp pages" },
        { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "[s]earch: [H]ighlights" },
        { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "[s]earch: [i]cons" },
        { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "[s]earch: [j]umps" },
        { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "[s]earch: [k]eymaps" },
        { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "[s]earch: [l]ocation list" },
        { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "[s]earch: [m]arks" },
        { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "[s]earch: [M]an pages" },
        { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "[s]earch: [p]lugin spec" },
        { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "[s]earch: [q]uickfix List" },
        { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "[s]earch: [r]esume" },
        { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "[s]earch: [u]ndo history" },
        { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },

        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "[g]oto [d]efinition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "[g]oto [D]eclaration" },
        { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                                 desc = "References" },
        { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "[g]oto [I]mplementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "[g]oto t[y]pe definition" },
        { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "[g]oto c[a]lls [i]ncoming" },
        { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "[g]oto c[a]lls [o]utgoing" },
        { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "L[s]P [s]ymbols" },
        { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "L[S]P Workspace [S]ymbols" },

        -- Other
        { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
        { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
        { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "[b]uffer [d]elete" },
        { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
        { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
        { "<c-_>",           function() Snacks.terminal() end,                                       desc = "Toggle terminal" },
        { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle terminal" },
        { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",                       mode = { "n", "t" } },
        { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",                       mode = { "n", "t" } },
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
