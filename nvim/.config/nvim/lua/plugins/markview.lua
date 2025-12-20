return {
	"OXY2DEV/markview.nvim",
	-- lazy = false,
	priority = 49,

	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("markview").setup({
			experimental = {
				check_rtp_message = false,
			},
			markdown = {
				tables = require("markview.presets").tables.rounded,
			},
		})
	end,
}
