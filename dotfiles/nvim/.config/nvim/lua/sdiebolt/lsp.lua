vim.lsp.enable({
    -- lua
    "lua",
    -- python
    "pyright",
    "ruff",
    -- rust
    "rust",
    -- typst
    "typst",
    -- harper
    "harper",
    -- bash
    "bash",
    -- ansible
    "ansible",
    -- yaml
    "yaml",
})

-- Disable LSP logging, as the LSP log file will otherwise grow indefinitely.
-- To enable logging, set the log level to "debug" when debugging LSP issues.
-- vim.lsp.set_log_level("off")

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
        local lsp = vim.lsp.buf
        local bufnr = args.buf

        local map = function(mode, lhs, rhs, opts)
            if opts.buffer == nil then
                opts.buffer = bufnr
            end
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("n", "gd", function() lsp.definition() end, { desc = "LSP: [g]o to [d]efinition" })
        map("n", "gD", function() lsp.declaration() end, { desc = "LSP: [g]o to [D]eclaration" })
        map("n", "gi", function() lsp.implementation() end, { desc = "LSP: [g]o to [i]mplementation" })
        map("n", "gr", function() lsp.references() end, { desc = "LSP: [g]o to [r]eferences" })
        map("n", "gs", function() lsp.signature_help() end, { desc = "LSP: [g]et [s]ignature help" })
        map("n", "gt", function() lsp.type_definition() end, { desc = "LSP: [g]o to [t]ype definition" })
        map("n", "K", function() lsp.hover() end, { desc = "LSP: [K]eyword hover" })

        map("n", "<leader>la", function() lsp.code_action() end, { desc = "LSP: [l]sp [a]ction" })
        map("n", "<leader>lf", function() lsp.format({ async = true }) end, { desc = "LSP: [l]sp [f]ormat" })
        map("n", "<leader>li",
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr }) end,
            { desc = "LSP: [l]sp [i]nlay hint" })

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

        if client.name == "rust_analyzer" then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false

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

            map("n", "<leader>lp", "<cmd>TypstPin<CR>", { desc = "LSP: [l]sp [p]in main Typst file" })
            map("n", "<leader>ltp", "<cmd>TypstPreview<CR>", { desc = "LSP: [l]sp [t]ypst [p]review" })
        end
    end,
})
