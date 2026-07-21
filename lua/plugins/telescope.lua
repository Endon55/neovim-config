return {
'nvim-telescope/telescope.nvim', version = '*',
dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
      		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } 	
      },
      config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        --vim.keymap.set('n', '<leader>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = '[S]earch current [B]uffer' })
        vim.keymap.set('n', '<leader>sa', builtin.live_grep, { desc = '[S]earch [A]ll' })
        
        vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
        vim.keymap.set('n', '<leader>sas', builtin.lsp_workspace_symbols, { desc = '[S]earch [A]ll [S]ymbols' })

      end
}

