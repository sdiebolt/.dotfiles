return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    settings = {
        checkOnSave = {
            command = "clippy",
        },
        procMacro = {
            enable = true,
        },
    },
}
