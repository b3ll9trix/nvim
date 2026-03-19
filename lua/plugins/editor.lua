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

    -- Find and replace (IDE-like)
    {
        "MagicDuck/grug-far.nvim",
        keys = {
            { "<leader>sr", function() require("grug-far").open() end, desc = "Search and Replace" },
            { "<leader>sr", function() require("grug-far").with_visual_selection() end, mode = "v", desc = "Search selection" },
            { "<leader>sR", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "Replace in file" },
        },
        config = function()
            require("grug-far").setup()
        end,
    },

    -- Smooth scrolling
    {
        "karb94/neoscroll.nvim",
        keys = {
            { "<C-d>", function() require("neoscroll").ctrl_d({ duration = 200, easing = "sine" }) end, desc = "Smooth half page down" },
            { "<C-u>", function() require("neoscroll").ctrl_u({ duration = 200, easing = "sine" }) end, desc = "Smooth half page up" },
        },
        config = function()
            require("neoscroll").setup({
                mappings = {}, -- disable default mappings, we define our own
            })
        end,
    },
}
