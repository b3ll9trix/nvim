-- Git integration
return {
    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local opts = function(desc) return { buffer = bufnr, desc = desc } end
                    vim.keymap.set("n", "]h", gs.next_hunk, opts("Next hunk"))
                    vim.keymap.set("n", "[h", gs.prev_hunk, opts("Previous hunk"))
                    vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts("Stage hunk"))
                    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts("Reset hunk"))
                    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts("Stage buffer"))
                    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts("Undo stage hunk"))
                    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts("Preview hunk"))
                    vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, opts("Blame line"))
                    vim.keymap.set("n", "<leader>hd", gs.diffthis, opts("Diff this"))
                end,
            })
        end,
    },

    -- Git commands
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G" },
    },

    -- Git diff viewer
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
        keys = {
            { "<leader>gd", ":DiffviewOpen<CR>", desc = "Open Diffview" },
        },
    },

    -- Git conflict resolution
    {
        "akinsho/git-conflict.nvim",
        event = "VeryLazy",
        config = function()
            require("git-conflict").setup()
        end,
    },
}
