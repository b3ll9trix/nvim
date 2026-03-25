-- AI assistants: Claude Code (chat/agent) + Windsurf (Codeium) inline completions
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

    -- Chat/agent (Claude Code)
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
}
