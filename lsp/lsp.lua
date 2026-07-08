require('mason').setup()

require('mason-tool-installer').setup({
	ensure_installed = {
		'lua_ls',
		'clangd',
	}

}

require('mason-lspconfig').setup({
	automatic_enable = true,
})
