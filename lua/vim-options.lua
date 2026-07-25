vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename Symbol' })
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = 'a'
vim.keymap.set('n', '<S-CR>', 'O<Esc>')
vim.keymap.set('n', '<CR>', 'o<Esc>')
vim.keymap.set('n', '<leader>th', function() vim.cmd("LspClangdSwitchSourceHeader") end, { desc = 'Switch Header'})
vim.keymap.set('n', '<leader>tth', function() vim.cmd("vsplit") vim.cmd("LspClangdSwitchSourceHeader") end, { desc = 'Switch Header'})
vim.keymap.set('n', '<leader>;', 'A;<Esc>', {desc = 'Append Semicolon'})
vim.keymap.set('i', '<C-e>', '<Esc>A;<Esc>', {desc = 'Append Semicolon insert'})
vim.keymap.set('i', "jkl", '<Esc>:up<CR>', {desc = "leave insert and save"})
if vim.fn.filereadable("CMakeLists.txt") == 1 then
    vim.keymap.set('n','<C-b>', ':wa|:CMakeBuild<CR>', {})
elseif vim.fn.filereadable("ols.json") == 1 then
    vim.keymap.set('n','<C-b>', ':wa|:!odin run src<CR>')
end


vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
    --update_in_insert = true,
})

