return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
			opts = {
				ui = {
				    icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
		    			}
				}
			}
		
    		end
	},
	{
		'neovim/nvim-lspconfig',
	},
	{
    		"mason-org/mason-lspconfig.nvim",
		keys = {
		},
    		opts = {
			ensure_installed = {"lua_ls", "clangd"}
		},
       	},
	{
  		'WhoIsSethDaniel/mason-tool-installer.nvim',
 		 dependencies = { 'mason-org/mason.nvim' },
 		 opts = {
   			 ensure_installed = {
      				'lua_ls',
				'clangd'
			},

  		},
	},
} 
