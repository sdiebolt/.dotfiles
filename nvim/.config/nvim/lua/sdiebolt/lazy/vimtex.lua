return {
    "lervag/vimtex",
    lazy = false,
    tag = "v2.15",
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "tectonic"
        vim.g.vimtex_compiler_tectonic = {
            options = {
                '--keep-logs',
                '--synctex',
                '--keep-intermediates'
            }
        }
    end
}
