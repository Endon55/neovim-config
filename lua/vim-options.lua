vim.opt.number = true
vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n','<C-b>', ':wa|:CMakeBuild<CR>', {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename Symbol' })
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = 'a'
vim.keymap.set('n', '<S-CR>', 'O<Esc>')
vim.keymap.set('n', '<CR>', 'o<Esc>')
vim.keymap.set('n', '<leader>th', function() vim.cmd("LspClangdSwitchSourceHeader") end, { desc = 'Switch Header'})
vim.keymap.set('n', '<leader>tth', function() vim.cmd("vsplit") vim.cmd("LspClangdSwitchSourceHeader") end, { desc = 'Switch Header'})
