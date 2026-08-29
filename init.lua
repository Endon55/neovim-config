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
vim.filetype.add({
    extension = {
        slang = "slang",
    },
})

local harpoon = require("harpoon")

	harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list-
    	vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
	    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)



-- local save_timer = nil
--
-- local function clear_cmdarea()
--   -- If a clearing timer is already running, cancel it
--   if save_timer then
--     vim.loop.timer_stop(save_timer)
--   end
--
--   -- Schedule a fresh, clean clear 800ms from now
--   save_timer = vim.defer_fn(function()
--     vim.api.nvim_echo({}, false, {})
--     save_timer = nil
--   end, 800)
-- end
--
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, { -- Removed 'TextChanged' to prevent blocking the LSP compiler
--   group = vim.api.nvim_create_augroup("LspSafeAutoSave", { clear = true }),
--   callback = function()
--     -- Ensure it's a real file, it has been changed, and it is modifiable
--     if #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted and vim.bo.modified and vim.bo.modifiable then
--
--       -- Save silently
--       vim.cmd "silent w"
--
--       -- Print nice colored msg safely
--       local time = os.date "%I:%M %p"
--       vim.api.nvim_echo({ { "  ", "LazyProgressDone" }, { " file autosaved at " .. time } }, false, {})
--
--       clear_cmdarea()
--     end
--   end,
-- })



local odin_save_group = vim.api.nvim_create_augroup("OdinAutoSave", { clear = true })

-- Handles leaving Insert mode, general Text changes, and pauses in Normal mode
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "CursorHold" }, {
    group = odin_save_group,
    pattern = "*.odin",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
    nested = true,
})

-- Handles typing pauses while actively inside Insert Mode
vim.api.nvim_create_autocmd("CursorHoldI", {
    group = odin_save_group,
    pattern = "*.odin",
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
    nested = true,
})
vim.opt.updatetime = 300

