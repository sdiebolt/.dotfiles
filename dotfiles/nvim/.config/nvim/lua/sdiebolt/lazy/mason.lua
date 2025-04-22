return {
    "WhoIsSethDaniel/mason-lspconfig.nvim",

    dependencies = { "williamboman/mason.nvim" },

    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "basedpyright",
                "lua_ls",
                "ruff",
                "tinymist",
                "harper_ls",
            },
        })
    end,
}
