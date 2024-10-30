return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",

        branch = "canary",

        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },

        opts = {
            model = "claude-3.5-sonnet",
        },
    },
}
