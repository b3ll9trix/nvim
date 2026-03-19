-- AI assistants: Avante (chat/agent) + Windsurf (Codeium) inline completions
return {
    -- Inline completions (Codeium)
    {
        "Exafunction/windsurf.vim",
        event = "BufEnter",
        config = function()
            vim.g.codeium_enabled = true
            vim.g.codeium_disable_bindings = 1
            vim.g.codeium_tab_fallback = ""

            -- Accept suggestion with Ctrl-y (dedicated key, no Tab conflict)
            vim.keymap.set("i", "<C-y>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true, silent = true })

            -- Cycle through suggestions
            vim.keymap.set("i", "<M-]>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true, silent = true })
            vim.keymap.set("i", "<M-[>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true, silent = true })

            -- Dismiss suggestion
            vim.keymap.set("i", "<M-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true, silent = true })

            -- Normal mode keymaps (<leader>i = inline completions)
            vim.keymap.set("n", "<leader>it", "<cmd>Codeium Toggle<CR>", { desc = "Toggle Codeium" })
            vim.keymap.set("n", "<leader>id", "<cmd>Codeium Disable<CR>", { desc = "Disable Codeium" })
            vim.keymap.set("n", "<leader>ie", "<cmd>Codeium Enable<CR>", { desc = "Enable Codeium" })
            vim.keymap.set("n", "<leader>ic", "<cmd>Codeium Chat<CR>", { desc = "Codeium chat" })
        end,
    },

    -- Chat/agent (Avante)
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false,
        build = "make",
        opts = {
            provider = "claude",
            mode = "agentic",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-opus-4-20250514",
                    auth_type = "max",
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 20480,
                    },
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
