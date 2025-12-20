return {
	"stevearc/oil.nvim",
	lazy = false,
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Optional dependencies

	config = function()
		require("oil").setup({
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		})
	end,
}
