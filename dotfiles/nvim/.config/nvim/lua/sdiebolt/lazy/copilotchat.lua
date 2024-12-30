return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",

        branch = "main",

        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },

        opts = {
            model = "claude-3.5-sonnet",
        },
    },
}
