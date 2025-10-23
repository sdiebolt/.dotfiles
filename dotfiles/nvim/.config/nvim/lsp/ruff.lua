return {
    cmd = { "uvx", "ruff", "server" },

    filetypes = { "python" },

    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },

    on_attach = function(client, bufnr)
        -- Disable hover in favor of the python LSP.
        client.server_capabilities.hoverProvider = false

        -- Organize imports on save.
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.code_action({
                    context = { only = { "source.organizeImports.ruff" } },
                    apply = true,
                })
                vim.wait(100)
            end,
        })
    end,
}
