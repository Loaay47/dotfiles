return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	},
	keys = function()
		local keys = {}
		local harpoon = require("harpoon")
		table.insert(keys, {
			"<leader>a",
			function()
				harpoon:list():add()
			end,
		})
		table.insert(keys, {
			"<C-e>",
			function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
		})
		table.insert(keys, {
			"<M-h>",
			function()
				harpoon:list():select(1)
			end,
		})

		table.insert(keys, {
			"<M-t>",
			function()
				harpoon:list():select(2)
			end,
		})

		table.insert(keys, {
			"<M-n>",
			function()
				harpoon:list():select(3)
			end,
		})

		table.insert(keys, {
			"<M-s>",
			function()
				harpoon:list():select(4)
			end,
		})

		return keys
	end,
}
