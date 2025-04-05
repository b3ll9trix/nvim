-- lua/plugins/neo-tree.lua
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- for file icons
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = true,
            enable_diagnostics = true,
	    source_selector = {
		winbar = true,
	    },
	    window = {
	    	mappings = {
			["P"] = {
				"toggle_preview",
				config = { 
					use_float = true
				},
			},
		},
	    },
        })

        -- Keybinding to toggle neo-tree
        vim.keymap.set('n', '<Leader>e', ':Neotree filesystem reveal toggle<CR>', { desc = 'Toggle NeoTree file explorer' })
	-- shift focus to explorer
	vim.keymap.set('n', '<Leader>f', ':Neotree action=focus<CR>', { desc = 'Shift focus to file explorer' })
	-- open git status as floating
	vim.keymap.set('n', '<Leader>g', ':Neotree float git_status<CR>', { desc = 'Open the git status floating window' })

	
    end
}
