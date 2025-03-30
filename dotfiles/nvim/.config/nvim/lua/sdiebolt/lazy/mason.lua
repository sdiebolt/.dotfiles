return {
    "williamboman/mason.nvim",

    opts = {
        ensure_installed = {
            "rust_analyzer",
            "basedpyright",
            "lua_ls",
            "ruff",
            "tinymist",
        },
    },
}
