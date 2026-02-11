-- Debug Adapter Protocol (DAP) configuration for Go and Rust
return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- UI for DAP
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                config = function()
                    local dapui = require("dapui")
                    dapui.setup({
                        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                        layouts = {
                            {
                                elements = {
                                    { id = "scopes", size = 0.25 },
                                    { id = "breakpoints", size = 0.25 },
                                    { id = "stacks", size = 0.25 },
                                    { id = "watches", size = 0.25 },
                                },
                                position = "left",
                                size = 40,
                            },
                            {
                                elements = {
                                    { id = "repl", size = 0.5 },
                                    { id = "console", size = 0.5 },
                                },
                                position = "bottom",
                                size = 10,
                            },
                        },
                    })

                    -- Auto open/close DAP UI
                    local dap = require("dap")
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
            },
            -- Virtual text for variables
            {
                "theHamsta/nvim-dap-virtual-text",
                config = function()
                    require("nvim-dap-virtual-text").setup({
                        commented = true,
                    })
                end,
            },
            -- Go debugging
            {
                "leoluz/nvim-dap-go",
                config = function()
                    require("dap-go").setup({
                        dap_configurations = {
                            {
                                type = "go",
                                name = "Debug Package",
                                request = "launch",
                                program = "${fileDirname}",
                            },
                        },
                    })
                end,
            },
            -- Mason DAP integration
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = { "williamboman/mason.nvim" },
                config = function()
                    require("mason-nvim-dap").setup({
                        ensure_installed = { "delve", "codelldb" },
                        automatic_installation = true,
                    })
                end,
            },
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue/Start" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
            { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
            { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
            { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate", mode = { "n", "v" } },
        },
        config = function()
            local dap = require("dap")

            -- Breakpoint signs
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "DapStoppedLine", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })

            -- Rust/C/C++ debugging with codelldb
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
        end,
    },
}
