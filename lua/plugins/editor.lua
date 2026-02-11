-- Editor utilities: autopairs, comments, surround, etc.
return {
    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Comments
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n", desc = "Comment line" },
            { "gc", mode = "v", desc = "Comment selection" },
        },
        config = function()
            require("Comment").setup()
        end,
    },

    -- Surround
    {
        "tpope/vim-surround",
        event = "VeryLazy",
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup()
        end,
    },

    -- Highlight word under cursor
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("illuminate").configure({
                delay = 100,
                under_cursor = true,
            })
        end,
    },
}
