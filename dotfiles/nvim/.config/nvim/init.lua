require("sdiebolt")

vim.lsp.enable({
    -- lua
    "luals",
    -- python
    "pyright",
    "ruff",
    -- rust
    "rust_analyzer",
    -- typst
    "tinymist",
})

-- Disable LSP logging, as the LSP log file will otherwise grow indefinitely.
-- To enable logging, set the log level to "debug" when debugging LSP issues.
vim.lsp.set_log_level("off")

-- Add border to the diagnostic popup window
local border = "single"
vim.diagnostic.config({
    virtual_text = {
        prefix = "■ ", -- Could be "●", "▎", "x", "■", , 
    },
    float = { border = border },
})
-- This can be used in the future to set the border for all floating windows. For now
-- it breaks a few plugins, so it's commented out.
-- vim.o.winborder = "single"

-- Set up format on save and inlay hints for LSP clients that support it.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end

        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end

        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
    desc = "LSP: Enable format on save"
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end

        if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = "LSP: Disable hover capability from Ruff",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end

        -- Setup ruff to organize imports on save.
        if client.name == "ruff" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.code_action({
                        context = { only = { "source.organizeImports.ruff" } },
                        apply = true,
                    })
                    vim.wait(100)
                end,
            })
        end
    end,
    desc = "LSP: Enable organize imports on save from Ruff",
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end

        if client.name == "tinymist" then
            -- Command to pin main file in multi-file Typst projects.
            vim.api.nvim_create_user_command("TypstPin", function()
                client:exec_cmd(
                    {
                        title = "Pin main Typst file",
                        command = "tinymist.pinMain",
                        arguments = { vim.api.nvim_buf_get_name(0) }
                    },
                    { bufnr = vim.api.nvim_get_current_buf() },
                    function(err)
                        if err then
                            vim.notify(("Error pinning: %s"):format(err.message), vim.log.levels.ERROR)
                        else
                            vim.notify("Succesfully pinned!", vim.log.levels.INFO)
                        end
                    end
                )
            end, {})
        end
    end,
})
