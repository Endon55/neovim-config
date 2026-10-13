return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0", -- Recommended stable branch
    config = function()
        local mc = require("multicursor-nvim")

        mc.setup()

        -- Add cursors visually or vertically
        vim.keymap.set({"n", "v"}, "<C-up>", function() mc.lineAddCursor(-1) end, {desc = "+Cursor Up"})
        vim.keymap.set({"n", "v"}, "<C-down>", function() mc.lineAddCursor(1) end, {desc = "+Cursor Down"})

        -- Match words under cursor (similar to Ctrl+D in VS Code)
        vim.keymap.set({"n", "v"}, "<leader>n", function() mc.matchAddCursor(1) end, {desc = "+Cursor prev match"})
        vim.keymap.set({"n", "v"}, "<leader>N", function() mc.matchAddCursor(-1) end, {desc = "+Cursor next match"})

        -- Skip or Delete cursors
        vim.keymap.set({"n", "v"}, "<leader>x", function() mc.deleteCursor() end, {desc = "-Cursor"})

        -- Clear all cursors with Escape
        vim.keymap.set("n", "<Esc>", function()
            if mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default escape behavior
            end
        end)
    end
}
