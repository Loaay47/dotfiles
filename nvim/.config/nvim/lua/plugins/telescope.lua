return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = require("telescope.themes").get_ivy({
					layout_config = {
                        height = 0.40,
					},
					preview = false,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"-uu",
					},
				}),
			})

			telescope.load_extension("fzf")

			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files({ hidden = true })
			end, {})
			vim.keymap.set("n", "<leader>gh", require("telescope.builtin").help_tags)
			vim.keymap.set("n", "<C-p>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>to", function()
				require("telescope.builtin").buffers()
			end)

			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
		end,
	},
}
