return {
    "nvim-treesitter/nvim-treesitter",

    lazy = false,

    brain = "main",

    build = ":TSUpdate",

    main = "nvim-treesitter.configs",

    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "bash",
            "html",
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
    }
}
