return {
    "lewis6991/gitsigns.nvim",

    config = function()
        require("gitsigns").setup({
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 200,
                ignore_whitespace = true,
                virt_text_priority = 100,
            },

            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
            end,
        })

        require("scrollbar.handlers.gitsigns").setup()
    end,
}
