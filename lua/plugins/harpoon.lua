return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
    	harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon [A]add" })
		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon [1] Binding" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon [2] Binding" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon [3] Binding" })
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon [4] Binding" })
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon list"})
		-- Toggle previous & next buffers stored within Harpoon list-
    	vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon Prev" })
	    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon Next" })

        end
    }

