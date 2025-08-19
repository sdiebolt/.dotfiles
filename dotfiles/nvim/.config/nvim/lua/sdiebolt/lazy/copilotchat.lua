return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",

        branch = "main",

        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },

        build = "make tiktoken", -- Only on macOS or Linux.

        opts = {
            model = "claude-sonnet-4",
        },
    },
}
