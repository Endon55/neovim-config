vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.updatetime = 300
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = 'a'

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = "Preview Symbol Def"})

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename Symbol' })
vim.keymap.set('n', '<S-CR>', 'O<Esc>')
vim.keymap.set('n', '<CR>', 'o<Esc>')

vim.keymap.set('n', '<leader>th', function() vim.cmd("LspClangdSwitchSourceHeader") end, { desc = '[T]oggle [H]eader'})
vim.keymap.set('n', '<leader>tth', function() vim.cmd("vsplit") vim.cmd("LspClangdSwitchSourceHeader") end, { desc = '[T]oggle [H]eader vsplit'})

vim.keymap.set({ "n", "x", "o" }, "[[", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, {desc = "Goto Prev Function"})
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, {desc = "Goto Next Function"})
vim.keymap.set('n', '<leader>;', 'A;<Esc>', {desc = 'Append Semicolon'})
vim.keymap.set('i', '<C-e>', '<Esc>A;<Esc>', {desc = 'Append Semicolon insert'})
-- vim.keymap.set('i', "jkl", '<Esc>:up<CR>', {desc = "leave insert and save"})

if vim.fn.filereadable("CMakeLists.txt") == 1 then
    vim.keymap.set('n','<C-b>', ':wa|:CMakeBuild<CR>', {desc = "[B]uild Project"})
elseif vim.fn.filereadable("ols.json") == 1 then
    -- vim.keymap.set('n','<C-b>', ':wa|:silent !./run.sh<CR>')
    vim.keymap.set('n','<C-b>', function()
        vim.cmd('write')
        local run_cmd = './run.sh'
        vim.fn.system("tmux send-keys -t .1 -X cancel")
        vim.fn.system("tmux send-keys -t .1 '" .. run_cmd .. "' C-m")

    end, {desc = "[B]uild in tmux pane"})
end

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})
--Disable ctlr-z

vim.keymap.set({'n', 'v', 'i'}, '<C-z>', '<Nop>', { silent = true })
vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })


--Toggle Themes
vim.keymap.set('n', '<leader>tt', function()

    -- 1. Programmatically grab the current active profile ID from the system
    local handle = io.popen("gsettings get org.gnome.Terminal.ProfilesList default")
    if not handle then return end
    local profile_id = handle:read("*a"):gsub("['\n%s]", "") -- Strip single quotes and line breaks
    handle:close()

    -- If it failed to grab an ID, exit early to prevent errors
    if profile_id == "" then return end
    local is_light = (vim.g.colors_name == "tokyonight-day")
    vim.cmd("hi clear")

    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end
    if is_light then
        vim.o.background = "dark"
        vim.cmd("colorscheme eldritch")
        package.loaded["eldritch"] = nil
        package.loaded["eldritch.palette"] = nil
        package.loaded["eldritch.highlights"] = nil
        package.loaded["eldritch.config"] = nil

        -- Load theme fresh
        require("eldritch").setup({})
        vim.cmd("colorscheme eldritch")
        os.execute(string.format("gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:%s/ use-theme-colors false", profile_id))
        os.execute(string.format("gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:%s/ background-color '#13121c'", profile_id))
        os.execute(string.format("gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:%s/ foreground-color '#c5c5c5'", profile_id))

    else
        vim.o.background = "light"
        vim.cmd("colorscheme tokyonight-day")
        os.execute(string.format("gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:%s/ use-theme-colors false", profile_id))
        os.execute(string.format("gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:%s/ background-color '#e1e2e7'", profile_id))
        os.execute(string.format("gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:%s/ foreground-color '#3760bf'", profile_id))
    end

    local has_lualine, lualine = pcall(require, "lualine")
    if has_lualine then
        lualine.setup({ options = { theme = vim.g.colors_name } })
    end

    -- Refresh nvim-scrollbar (if used)
    local has_scrollbar, scrollbar = pcall(require, "scrollbar")
    if has_scrollbar then
        scrollbar.clear()
    end
end, {desc = "[T]oggle [T]heme light/dark"})


