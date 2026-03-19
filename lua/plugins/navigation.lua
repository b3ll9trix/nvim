-- Navigation: File explorer, fuzzy finder
return {
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
            { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus file tree" },
            { "<leader>nf", "<cmd>NvimTreeFindFile<CR>", desc = "Find current file" },
        },
        config = function()
            local function on_attach(bufnr)
                local api = require("nvim-tree.api")
                -- Apply default mappings first
                api.config.mappings.default_on_attach(bufnr)
                local opts = { buffer = bufnr, silent = true, noremap = true }

                -- Grep inside selected folder
                vim.keymap.set("n", "<leader>fg", function()
                    local node = api.tree.get_node_under_cursor()
                    local path = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
                    require("telescope.builtin").live_grep({ search_dirs = { path } })
                end, vim.tbl_extend("force", opts, { desc = "Grep in folder" }))

                -- Find files inside selected folder
                vim.keymap.set("n", "<leader>ff", function()
                    local node = api.tree.get_node_under_cursor()
                    local path = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
                    require("telescope.builtin").find_files({ search_dirs = { path } })
                end, vim.tbl_extend("force", opts, { desc = "Find files in folder" }))
            end

            require("nvim-tree").setup({
                on_attach = on_attach,
                view = {
                    width = 35,
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                    icons = {
                        hint = "💡",
                        info = "ℹ️",
                        warning = "⚠️",
                        error = "❌",
                    },
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        diagnostics_placement = "before",
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

    -- Quick jump (flash)
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
        },
        opts = {},
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
                    path_display = { "filename_first" },
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
}
