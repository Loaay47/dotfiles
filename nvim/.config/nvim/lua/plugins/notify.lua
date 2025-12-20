return {
	"rcarriga/nvim-notify",
	enabled = false,
	config = function()
		vim.notify = require("notify")
		require("notify").setup({
			background_colour = "#000000",
			timeout = 3000,
			stages = "slide",
		})
	end,
}
