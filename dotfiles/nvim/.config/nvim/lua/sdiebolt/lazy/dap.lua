return {
    {
        "mfussenegger/nvim-dap",

        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python"
        },

        keys = {
            { "<leader>ds", function() require("dap").continue() end,          desc = "DAP: Continue/start debug" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
            { "<leader>dx", function() require("dap").terminate() end,         desc = "DAP: Terminate debug" },
            { "<leader>do", function() require("dap").step_over() end,         desc = "DAP: Step over" },
            { "<leader>di", function() require("dap").step_into() end,         desc = "DAP: Step into" },
        },

        config = function()
            require("dap-python").setup(os.getenv("VIRTUALENVS") .. "/debugpy/bin/python")

            -- Signs
            local sign = vim.fn.sign_define
            sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

            -- nvim-dap-ui
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    }
}
