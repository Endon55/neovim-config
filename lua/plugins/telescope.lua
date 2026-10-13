return {
'nvim-telescope/telescope.nvim', version = '*',
dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
      		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
      },
      opts = {
          defaults = {
              file_ignore_patterns= {
                  "build/", "%.git/", "bin/", "libs/", "target/",
                  "%.so$", "%.o$", "%.a", "%.bin$", "%.dmg$", "%.iso$",
                  "%.spv$",
              },
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
              find_files = {
                    hidden = true,
                    no_ignore = true,
                  -- Pass custom flags to ripgrep for find_files
                  -- find_command = { "rg", "--files", "--hidden", "--no-ignore" },
    }
          },
      },
      keys = {

          { '<C-p>', function() require("telescope.builtin").find_files() end, desc = "Find Files" },
          { '<leader>sb', function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "[S]earch current [B]uffer" },
          { '<leader>sa', function() require("telescope.builtin").live_grep() end, desc = "[S]earch [A]ll" },
          { '<leader>ss', function() require("telescope.builtin").lsp_document_symbols() end, desc = "[S]earch [S]ymbols" },
          { '<leader>sas', function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "[S]earch [A]ll [S]ymbols" },
          { '<leader>sf', function() require("telescope.builtin").lsp_document_symbols({symbols = { "function", "method" },})end, desc = "[S]earch [F]unctions" },
          { '<leader>saf', function() require("telescope.builtin").lsp_dynamic_workspace_symbols({symbols = { "function", "method" },})end, desc = "[S]earch [A]ll [F]unctions" },
          { '<leader>sd', function() require("telescope.builtin").diagnostics() end, desc = "[S]earch [D]iagnostics" },
      },
}

