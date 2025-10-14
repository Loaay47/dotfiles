return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			transparent = false,
			transparent_mode = false,
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
			contrast = "hard",
			dim_inactive = false,
			overrides = {
				SignColumn = { bg = "none" },
				LineNr = { bg = "none" },
				CursorLineNr = { bg = "none" },
				VertSplit = { bg = "none", fg = "#3c3836" },
				NormalNC = { bg = "none" },
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				Folded = { bg = "none" },
				Pmenu = { bg = "#1d2021" },
			},
		})
		vim.o.background = "dark"
		vim.cmd.colorscheme("gruvbox")
	end,
}
