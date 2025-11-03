return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        win = {
            border = "single",
        },
        spec = {
            {
                mode = { "n", "v" },
                { "<leader>a", group = "[a]vante" },
                { "<leader>b", group = "[b]uffer" },
                { "<leader>d", group = "[d]ebug" },
                { "<leader>f", group = "[f]ind" },
                { "<leader>g", group = "[g]it" },
                { "<leader>h", group = "[h]arpoon" },
                { "<leader>i", group = "[i]ron" },
                { "<leader>l", group = "[l]sp" },
                { "<leader>n", group = "[n]eotree" },
                { "<leader>n", group = "[n]otifications" },
                { "<leader>r", group = "[r]eplace" },
                { "<leader>s", group = "[s]earch" },
                { "<leader>t", group = "[t]rouble" },
                { "<leader>T", group = "[T]ypst" },
                { "<leader>u", group = "[u]i" },
                { "<leader>U", group = "[U]ndotree" },
                { "<leader>v", group = "[v]irtualenv" },
                { "[",         group = "prev" },
                { "]",         group = "next" },
                { "g",         group = "goto" },
                { "z",         group = "fold" },
            },
        }
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
