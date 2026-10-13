return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window Go Left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window Go Down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window Go Up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window Go Right" },
    },
  }
}
