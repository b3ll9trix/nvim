-- AI assistants: Claude Code integration + Windsurf (Codeium) inline completions
return {
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

            -- Normal mode keymaps
            vim.keymap.set("n", "<leader>at", "<cmd>Codeium Toggle<CR>", { desc = "Toggle Codeium" })
            vim.keymap.set("n", "<leader>ad", "<cmd>Codeium Disable<CR>", { desc = "Disable Codeium" })
            vim.keymap.set("n", "<leader>ae", "<cmd>Codeium Enable<CR>", { desc = "Enable Codeium" })
            vim.keymap.set("n", "<leader>ai", "<cmd>Codeium Chat<CR>", { desc = "Codeium chat" })
        end,
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        keys = {
            { "<leader>ac", "<cmd>ClaudeCode<CR>",            desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<CR>",       desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<CR>",   desc = "Resume conversation" },
            { "<leader>as", "<cmd>ClaudeCodeSend<CR>",        mode = "v",                    desc = "Send to Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Select model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>",       desc = "Add buffer to context" },
        },
        config = function()
            require("claudecode").setup({
                terminal = {
                    split_side = "right",
                    split_width_percentage = 0.30,
                    provider = "snacks",
                },
                diff_opts = {
                    auto_close_on_accept = true,
                    vertical_split = true,
                },
            })
        end,
    },
}
