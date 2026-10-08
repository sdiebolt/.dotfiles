return {
    "nvim-treesitter/nvim-treesitter",

    lazy = false,

    branch = "main",

    build = ":TSUpdate",

    opts = {
        ensure_installed = {
            "c",
            "cpp",
            "cuda",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "bash",
            "html",
            "astro",
            "css",
            "python",
            "typescript",
            "tsx",
            "rust",
            "markdown",
            "markdown_inline",
            "typst",
            "latex",
            "just",
        },
        sync_install = false,
        auto_install = true,
        indent = { enable = true },
        highlight = { enable = true },
    },

    config = function(_, opts)
        local ts = require("nvim-treesitter")

        ts.setup()
        ts.install(opts.ensure_installed)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
