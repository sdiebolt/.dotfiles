return {
    cmd = function(dispatchers, config)
        local cmd = "astro-ls"
        local local_cmd = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/astro-ls"
        if local_cmd and vim.fn.executable(local_cmd) == 1 then
            cmd = local_cmd
        end
        return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
    end,

    filetypes = { "astro" },

    root_markers = { "astro.config.mjs", "package.json", "tsconfig.json", ".git" },
}
