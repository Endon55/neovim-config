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

-- vim.api.nvim_create_autocmd("InsertLeave", {
--   pattern = "*",
--   callback = function()
--     -- 1. Grab the active language server clients for the current file
--     local clients = vim.lsp.get_clients({ bufnr = 0 })
--
--     for _, client in ipairs(clients)  do
--       -- 2. Target ols to simulate a document sync
--       if client.name == "ols" then
--         local bufnr = vim.api.nvim_get_current_buf()
--
--         -- 3. Force Neovim to instantly notify ols of the textual changes
--         vim.lsp.buf_request(bufnr, "textDocument/didChange", vim.lsp.util.make_text_document_params())
--         break
--       end
--     end
--   end,
-- })
