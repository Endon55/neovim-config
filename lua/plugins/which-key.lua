return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    delay = 1000,
    win = {
        border = "double",
        wo = {
            winblend = 0,
        },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true})
      end, desc = "Buffer Local Keymaps (which-key)",
    },
 },
 }
