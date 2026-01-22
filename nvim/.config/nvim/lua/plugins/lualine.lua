return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",

	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "gruvbox-material",
			},
		})
	end,
}
