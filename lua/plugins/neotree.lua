return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
       		"nvim-lua/plenary.nvim",
       		"MunifTanjim/nui.nvim",
       		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	--lazy = false, -- neo-tree will lazily load itself
	keys = {
		{'<C-n>', ':Neotree filesystem reveal left<CR>', desc = "Show file tree", mode = "n"},
	},
	--config = function()
	--end,

	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false
			}
		}
	}
}

