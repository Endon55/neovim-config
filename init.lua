-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"



if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("vim-options")
require("lazy").setup("plugins", opts)
vim.filetype.add({
    extension = {
        slang = "slang",
    },
})

local odin_save_group = vim.api.nvim_create_augroup("OdinAutoSave", { clear = true })

-- Handles leaving Insert mode, general Text changes, and pauses in Normal mode
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "CursorHold" }, {
    group = odin_save_group,
    pattern = "*.odin",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
    nested = true,
})

-- Handles typing pauses while actively inside Insert Mode
vim.api.nvim_create_autocmd("CursorHoldI", {
    group = odin_save_group,
    pattern = "*.odin",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
    nested = true,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = 'term://*',
  callback = function()
    vim.cmd('bdelete! ' .. vim.fn.expand('<abuf>'))
  end,
})


local function silent_fuzzy_symbol_jump()
  vim.ui.input({ prompt = 'Fuzzy jump to symbol: ' }, function(query)
    if not query or query == "" then return end

    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, function(err, result, _, _)
      if err or not result or #result == 0 then
        print("No LSP symbols found in this file.")
        return
      end

      local symbol_list = {}
      local symbol_map = {}

      -- Recursively flatten code structure across all potential LSP formats
      local function flatten(items)
        for _, item in ipairs(items) do
          table.insert(symbol_list, item.name)
          -- Extract coordinates robustly: checks nested range first, then flat format location range
          local range = item.range or (item.location and item.location.range)
          symbol_map[item.name] = range
          if item.children then
            flatten(item.children)
          end
        end
      end
      flatten(result)

      -- Execute Neovim's built-in fuzzy matching
      local matches = vim.fn.matchfuzzy(symbol_list, query)

      if matches and #matches > 0 then
        local best_match_name = matches[1]
        local range = symbol_map[best_match_name]
        if range and range.start then
          -- LSP lines are 0-indexed, so we add 1 for Neovim's 1-indexed system
          vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
          vim.cmd("normal! zz")
        else
          print("Found match, but could not resolve its line coordinates.")
        end
      else
        print("No fuzzy match found for: " .. query)
      end
    end)
  end)
end

vim.keymap.set('n', '<leader>sd', silent_fuzzy_symbol_jump, { desc = 'Silent fuzzy symbol jump' })
