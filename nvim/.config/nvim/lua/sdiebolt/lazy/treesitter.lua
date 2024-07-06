return {
    "nvim-treesitter/nvim-treesitter",

    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,

    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "python", "typescript" },
        sync_install = false,
        auto_install = true,
        indent = { enable = true },
        highlight = { enable = true },
    }
}
