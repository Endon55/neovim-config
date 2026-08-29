return {
'nvim-telescope/telescope.nvim', version = '*',
dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
      		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
      },
      opts = {
          defaults = {
              mappings = {
                  n = {
                      -- Press 'q' in normal mode to close the telescope picker
                      ["q"] = function(...)
                          return require("telescope.actions").close(...)
                      end,
                  },
              },
          },
          pickers = {
              diagnostics = {
                  initial_mode = "normal",
              },
              buffers = {
                  initial_mode = "normal",
              },
          },
      },
      keys = {

          { '<C-p>', function() require("telescope.builtin").find_files() end, desc = "Find Files" },
          { '<leader>sb', function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "[S]earch current [B]uffer" },
          { '<leader>sa', function() require("telescope.builtin").live_grep() end, desc = "[S]earch [A]ll" },
          { '<leader>ss', function() require("telescope.builtin").lsp_document_symbols() end, desc = "[S]earch [S]ymbols" },
          { '<leader>sas', function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "[S]earch [A]ll [S]ymbols" },
          { '<leader>sd', function() require("telescope.builtin").diagnostics() end, desc = "[S]earch [D]iagnostics" },
      },

      
      -- config = function()
      --   local builtin = require("telescope.builtin")
      --   vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      --   vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = '[S]earch current [B]uffer' })
      --   vim.keymap.set('n', '<leader>sa', builtin.live_grep, { desc = '[S]earch [A]ll' })
      --   vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch [S]ymbols' })
      --   vim.keymap.set('n', '<leader>sas', builtin.lsp_workspace_symbols, { desc = '[S]earch [A]ll [S]ymbols' })
      --   vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- end
}

