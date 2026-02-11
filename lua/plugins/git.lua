-- Git integration
return {
    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup()
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
