return {
    "folke/trouble.nvim",

    opts = {},

    cmd = "Trouble",

    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Trouble: Diagnostics Window",
        },
        {
            "<leader>th",
            "<Cmd>lua vim.diagnostic.open_float()<CR>",
            desc = "Trouble: Diagnostics Hover",
        },
        {
            "<leader>tT",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Trouble: Buffer Diagnostics",
        },
        {
            "<leader>ts",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Trouble: Symbols",
        },
        {
            "<leader>tl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "Trouble: LSP Definitions / references / ...",
        },
        {
            "<leader>tL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Trouble: Location List",
        },
        {
            "<leader>tQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Trouble: Quickfix List",
        },
    },
}
