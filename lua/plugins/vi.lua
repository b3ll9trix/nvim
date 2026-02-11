-- UI: Theme, statusline, icons, bufferline
return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = false,
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                },
            })
        end,
    },

    -- Buffer line
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({})
        end,
    },

    -- Which-key (keybinding hints)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup()
        end,
    },

    -- Dashboard
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("dashboard").setup({
                theme = "hyper",
            })
        end,
    },

    -- Better UI for inputs/selects
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
}
