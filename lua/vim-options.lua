vim.opt.number = true
vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n','<C-m>', ':wa|:CMakeBuild<CR>', {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename Symbol' })
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
vim.opt.clipboard = "unnamedplus"
