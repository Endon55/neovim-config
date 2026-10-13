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

