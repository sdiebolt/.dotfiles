return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({ 
            disabled_filetypes = { "packer", "NVimTree" }
        })
    end
}
