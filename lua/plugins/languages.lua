-- Language-specific plugins (LSP, DAP, and Treesitter are configured elsewhere)
return {
    -- Go: Additional tools
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("gopher").setup({
                commands = {
                    go = "go",
                    gomodifytags = "gomodifytags",
                    gotests = "gotests",
                    impl = "impl",
                    iferr = "iferr",
                },
            })
        end,
        build = function()
            vim.cmd([[silent! GoInstallDeps]])
        end,
        keys = {
            { "<leader>gsj", "<cmd>GoTagAdd json<CR>", desc = "Add json tags", ft = "go" },
            { "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", desc = "Add yaml tags", ft = "go" },
            { "<leader>gsr", "<cmd>GoTagRm json<CR>", desc = "Remove json tags", ft = "go" },
            { "<leader>gie", "<cmd>GoIfErr<CR>", desc = "Add if err", ft = "go" },
            { "<leader>gim", "<cmd>GoImpl<CR>", desc = "Implement interface", ft = "go" },
            { "<leader>gtg", "<cmd>GoTestsAll<CR>", desc = "Generate all tests", ft = "go" },
        },
    },

    -- Crates.nvim for Cargo.toml
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup({
                popup = {
                    border = "rounded",
                },
                lsp = {
                    enabled = true,
                    on_attach = function(client, bufnr)
                        -- Keymaps for crates.nvim
                        local opts = { buffer = bufnr, silent = true }
                        vim.keymap.set("n", "<leader>ct", function() require("crates").toggle() end, vim.tbl_extend("force", opts, { desc = "Toggle crates" }))
                        vim.keymap.set("n", "<leader>cr", function() require("crates").reload() end, vim.tbl_extend("force", opts, { desc = "Reload crates" }))
                        vim.keymap.set("n", "<leader>cv", function() require("crates").show_versions_popup() end, vim.tbl_extend("force", opts, { desc = "Show versions" }))
                        vim.keymap.set("n", "<leader>cf", function() require("crates").show_features_popup() end, vim.tbl_extend("force", opts, { desc = "Show features" }))
                        vim.keymap.set("n", "<leader>cd", function() require("crates").show_dependencies_popup() end, vim.tbl_extend("force", opts, { desc = "Show dependencies" }))
                        vim.keymap.set("n", "<leader>cu", function() require("crates").update_crate() end, vim.tbl_extend("force", opts, { desc = "Update crate" }))
                        vim.keymap.set("n", "<leader>cU", function() require("crates").upgrade_crate() end, vim.tbl_extend("force", opts, { desc = "Upgrade crate" }))
                        vim.keymap.set("n", "<leader>cA", function() require("crates").upgrade_all_crates() end, vim.tbl_extend("force", opts, { desc = "Upgrade all" }))
                    end,
                    actions = true,
                    completion = true,
                },
            })
        end,
    },
}
