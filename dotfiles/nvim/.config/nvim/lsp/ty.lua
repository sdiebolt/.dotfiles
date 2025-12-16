return {
    cmd = { "uvx", "ty", "server" },

    filetypes = { "python" },

    root_markers = { "ty.toml", "pyproject.toml", ".git" },

    settings = {
        ty = {
            diagnosticMode = "workspace",
            inlayHints = {
                callArgumentNames = true,
            },
        }
    }
}
