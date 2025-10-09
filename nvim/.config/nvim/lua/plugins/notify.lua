return {
	"rcarriga/nvim-notify",
	config = function()
		vim.notify = require("notify")
		require("notify").setup({
			background_colour = "#000000",
			timeout = 1000,
      stages = 'slide',
		})
	end,
}
