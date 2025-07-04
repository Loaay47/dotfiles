return {
	"nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- ✅ Add this line
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
			},
		})
		vim.keymap.set("n", "fm", vim.lsp.buf.format, {})
	end,
}
