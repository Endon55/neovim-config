 return {
     {
	"eldritch-theme/eldritch.nvim",
	name = "eldritch",
	priority = 1000,
	lazy = false,
	config = function()
		require('eldritch').setup({
			vim.cmd.colorscheme"eldritch",
			transparent = true,
		})
	end,
},
{
    "erl-koenig/theme-hub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- Optional: for themes that use lush (will be notified if a theme requires it)
        -- "rktjmp/lush.nvim"
    },
    config = function()
        require("theme-hub").setup({
            -- Configuration options (see below)
        })
    end,
},
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}
}
--return { 
--"marko-cerovac/material.nvim",
--	name = "material", 
--	  priority = 1000,
--	  config = function()
--		require('material').setup({
--		})	  
--		vim.g.material_style = 'darker'
----		vim.cmd.colorscheme "material"
--	  end,
 -- }
 --
 --
