return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default',
    ['<C-c>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
},

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    signature = {
        enabled = true,
        window = {
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:FloatBorder,EndOfBuffer:Pmenu',
        },
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
        documentation = {
            auto_show = false
        },
        ghost_text = {
            enabled = true
        },
        menu = {
            auto_show = false,
        }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },

  config = function(_, opts)
    require('blink.cmp').setup(opts)

    -- blink always anchors the signature window to the cursor column; pin it to the
    -- left edge of the current window and stretch it across the full width instead
    local sig = require('blink.cmp.signature.window')
    local update_position = sig.update_position
    sig.update_position = function()
      update_position()
      if not sig.win:is_open() then return end
      local winnr = sig.win:get_win()
      local cfg = vim.api.nvim_win_get_config(winnr)
      local row = cfg.row
      if cfg.relative == 'cursor' then row = vim.fn.winline() - 1 + cfg.row end
      local target = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_config(winnr, {
        relative = 'win',
        win = target,
        row = row,
        col = 0,
        width = math.max(1, vim.api.nvim_win_get_width(target) - 2),
      })
    end
  end,
}
