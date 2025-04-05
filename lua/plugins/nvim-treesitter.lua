return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = "all",
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			},

			incremental_selection = {
		        	enable = true,
        			keymaps = {
            				init_selection = "gnn", -- Start selection
            				node_incremental = "grn", -- Expand to next node
            				scope_incremental = "grc", -- Expand to next scope
            				node_decremental = "grm", -- Shrink selection
        			},
    			},
			textobjects = {
        			enable = true,
        			keymaps = {
            				["af"] = "@function.outer", -- Around function
		        		["if"] = "@function.inner", -- Inner function
	    				["ac"] = "@class.outer", -- Around class
            				["ic"] = "@class.inner", -- Inner class
		        		["aL"] = "@loop.outer", -- Around loop
            				["iL"] = "@loop.inner", -- Inner loop
        			},
			},

		})
	end

}
