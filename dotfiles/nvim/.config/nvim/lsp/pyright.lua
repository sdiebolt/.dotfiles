return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    settings = {
        basedpyright = {
            -- Using Ruff"s import organizer.
            disableOrganizeImports = true,
            -- I use too many packages that don't have stubs.
            typeCheckingMode = "basic",
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use
                -- Ruff for linting.
                ignore = { "*" },
            },
        },
    },
}
