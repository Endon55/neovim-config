return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').setup {
                ensure_installed = {'lua', 'c', 'cpp', 'odin'},
                highlight = {enable = true},
                indent = {enable = true}
            }
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "odin",
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { "nvim-treesitter/nvim-treesitter" },

    }
}

