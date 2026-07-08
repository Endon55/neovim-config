 return {
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
