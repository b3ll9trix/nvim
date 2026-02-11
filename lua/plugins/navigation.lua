-- Navigation: File explorer, fuzzy finder, harpoon
return {
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
            { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus file tree" },
            { "<leader>nf", "<cmd>NvimTreeFindFile<CR>", desc = "Find current file" },
        },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 35,
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = "󰌵",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                            diagnostics = true,
                        },
                    },
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                actions = {
                    open_file = {
                        quit_on_open = false,
                    },
                },
            })
        end,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        cmd = "Telescope",
        keys = {
            -- Files
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Grep word under cursor" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
            -- Search
            { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in buffer" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
            { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
            { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
            -- LSP
            { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
            { "<leader>fo", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
            { "<leader>fO", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
            -- Git
            { "<leader>fgc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
            { "<leader>fgb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
            { "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
            -- Resume
            { "<leader>f.", "<cmd>Telescope resume<CR>", desc = "Resume last search" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git/", "target/", "vendor/" },
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<Esc>"] = actions.close,
                        },
                    },
                    layout_config = {
                        horizontal = {
                            preview_width = 0.55,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden" }
                        end,
                    },
                },
            })
            telescope.load_extension("fzf")
        end,
    },

    -- Harpoon (quick file switching)
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
            { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
            { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
            { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
            { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
            { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
            { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "Harpoon prev" },
            { "<leader>hn", function() require("harpoon"):list():next() end, desc = "Harpoon next" },
        },
        config = function()
            require("harpoon"):setup()
        end,
    },
}
