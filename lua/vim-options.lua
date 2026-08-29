vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.updatetime = 300
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

vim.keymap.set({ "n", "x", "o" }, "[[", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set('n', '<leader>;', 'A;<Esc>', {desc = 'Append Semicolon'})
vim.keymap.set('i', '<C-e>', '<Esc>A;<Esc>', {desc = 'Append Semicolon insert'})
vim.keymap.set('i', "jkl", '<Esc>:up<CR>', {desc = "leave insert and save"})
if vim.fn.filereadable("CMakeLists.txt") == 1 then
    vim.keymap.set('n','<C-b>', ':wa|:CMakeBuild<CR>', {})
elseif vim.fn.filereadable("ols.json") == 1 then
    vim.keymap.set('n','<C-b>', ':wa|:silent !./run.sh<CR>')
end


vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
    --update_in_insert = true,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = 'term://*',
  callback = function()
    vim.cmd('bdelete! ' .. vim.fn.expand('<abuf>'))
  end,
})
--Disable ctlr-z
vim.keymap.set({'n', 'v', 'i'}, '<C-z>', '<Nop>', { silent = true })

vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })
