-- UI: Theme, statusline, icons, bufferline
return {
    -- Color scheme
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                transparent = false,
            })
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            default = true,
            color_icons = true,
        },
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "kanagawa",
                },
                sections = {
                    lualine_c = {
                        { "filename", path = 1 },
                    },
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

    -- Breadcrumbs (winbar with LSP context)
    {
        "Bekaboo/dropbar.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
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
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        {
                            desc = " Find File",
                            group = "DashboardShortCut",
                            action = "Telescope find_files",
                            key = "f",
                        },
                        {
                            desc = " Recent Files",
                            group = "DashboardShortCut",
                            action = "Telescope oldfiles",
                            key = "r",
                        },
                        {
                            desc = " Grep",
                            group = "DashboardShortCut",
                            action = "Telescope live_grep",
                            key = "g",
                        },
                        {
                            desc = "󰒲 Lazy",
                            group = "DashboardShortCut",
                            action = "Lazy",
                            key = "l",
                        },
                        {
                            desc = " Quit",
                            group = "DashboardShortCut",
                            action = "qa",
                            key = "q",
                        },
                    },
                    project = {
                        enable = true,
                        limit = 5,
                        action = "Telescope find_files cwd=",
                    },
                    mru = {
                        limit = 8,
                    },
                    footer = {},
                },
            })
        end,
    },

    -- Better UI for inputs/selects
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
}
