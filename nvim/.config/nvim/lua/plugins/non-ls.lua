return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format.with({
					extra_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
				}),
				null_ls.builtins.formatting.google_java_format.with({
					extra_args = { "--aosp" },
				}),
			},
		})
		vim.keymap.set("n", "nm", vim.lsp.buf.format, {})
		local notify = vim.notify
		vim.notify = function(msg, ...)
			if type(msg) == "string" and msg:match("timeout") then
				return
			end
			notify(msg, ...)
		end
	end,
}
