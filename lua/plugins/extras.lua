-- Extra utilities: terminal, smooth scroll, trouble
return {
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
            { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float terminal" },
            { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<CR>", desc = "Horizontal terminal" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Vertical terminal" },
        },
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        return 15
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.4
                    end
                end,
                open_mapping = [[<C-\>]],
                direction = "float",
                float_opts = {
                    border = "curved",
                    winblend = 0,
                },
                highlights = {
                    FloatBorder = { guifg = "#89b4fa" },
                },
            })

            -- Terminal mode mappings
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
                vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        end,
    },

    -- Smooth scrolling
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            require("neoscroll").setup()
        end,
    },

    -- Trouble (diagnostics panel)
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle diagnostics" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
            { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Document symbols" },
            { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP definitions/refs" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
            { "]t", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next trouble" },
            { "[t", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous trouble" },
        },
        config = function()
            require("trouble").setup({
                auto_close = true,
                use_diagnostic_signs = true,
            })
        end,
    },
}
