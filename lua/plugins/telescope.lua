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
      config = function(_, opts)
          local telescope = require("telescope")
          telescope.setup(opts)
          pcall(telescope.load_extension, "fzf")
      end,
      keys = {
          { '<C-p>', function() require("telescope.builtin").find_files() end, desc = "Find Files" },
          { '<leader>sb', function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "[S]earch current [B]uffer" },
          { '<leader>sa', function() require("telescope.builtin").live_grep() end, desc = "[S]earch [A]ll" },
          { '<leader>ss', function() require("telescope.builtin").lsp_document_symbols() end, desc = "[S]earch [S]ymbols" },
          { '<leader>sas', function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "[S]earch [A]ll [S]ymbols" },
          { '<leader>sf', function() require("telescope.builtin").lsp_document_symbols({symbols = { "function", "method" },})end, desc = "[S]earch [F]unctions" },
          { '<leader>saf', function() require("telescope.builtin").lsp_dynamic_workspace_symbols({symbols = { "function", "method" },})end, desc = "[S]earch [A]ll [F]unctions" },
          { '<leader>sd', function() require("telescope.builtin").diagnostics() end, desc = "[S]earch [D]iagnostics" },

          { '<leader>sv', function()
              local s, e = vim.fn.line("v"), vim.fn.line(".")
              if s > e then s, e = e, s end
              vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
              vim.schedule(function()
                  local buf = vim.api.nvim_get_current_buf()
                  local win = vim.api.nvim_get_current_win()
                  local filename = vim.api.nvim_buf_get_name(buf)
                  local entries = {}
                  for i, l in ipairs(vim.api.nvim_buf_get_lines(buf, s - 1, e, false)) do
                      entries[#entries + 1] = { lnum = s + i - 1, text = vim.trim(l) }
                  end
                  local pickers = require("telescope.pickers")
                  local finders = require("telescope.finders")
                  local conf = require("telescope.config").values
                  local actions = require("telescope.actions")
                  local action_state = require("telescope.actions.state")
                  pickers.new({}, {
                      prompt_title = ("Filter lines %d-%d"):format(s, e),
                      finder = finders.new_table({
                          results = entries,
                          entry_maker = function(entry)
                              return {
                                  value = entry,
                                  ordinal = entry.text,
                                  display = ("%d: %s"):format(entry.lnum, entry.text),
                                  lnum = entry.lnum,
                                  col = 0,
                                  filename = filename,
                                  bufnr = buf,
                              }
                          end,
                      }),
                      sorter = conf.generic_sorter({}),
                      previewer = conf.grep_previewer({}),
                      attach_mappings = function(prompt_bufnr)
                          actions.select_default:replace(function()
                              local sel = action_state.get_selected_entry()
                              actions.close(prompt_bufnr)
                              if sel then vim.api.nvim_win_set_cursor(win, { sel.lnum, 0 }) end
                          end)
                          return true
                      end,
                  }):find()
              end)
          end, mode="x", desc = "[S]earch [V]isual selection (filter lines)" },
      },
}

