return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "mfussenegger/nvim-dap-python",

        config = function()
            require("dap-python").setup(os.getenv("VIRTUALENVS") .. "/debugpy/bin/python")
        end,
    }
}
