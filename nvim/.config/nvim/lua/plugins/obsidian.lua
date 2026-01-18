return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = false,

    keys = {
		{ "<leader>on", ":ObsidianToday<CR>"},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	opts = {
		disable_frontmatter = true,
		workspaces = {
			{
				name = "personal",
				path = "~/vault",
			},
		},
		-- Optional, if you keep notes in a specific subdirectory of your vault.
		notes_subdir = "2 - Source Materials",
		templates = {
			folder = "5 - Templates",
		},

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "6 - Journals/Daily",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = nil,
		},
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},
		ui = {
			enable = false,
		},
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				if vim.fn.expand("%:p"):find(vim.fn.expand("~/vault")) then
					vim.keymap.set("n", "<leader>pf", ":ObsidianQuickSwitch<CR>", { buffer = true, silent = true })
					vim.keymap.set("n", "<leader>wn", ":ObsidianOpen<CR>", { buffer = true, silent = true })
					vim.keymap.set("n", "<leader>wm", ":ObsidianTemplate<CR>", { buffer = true, silent = true })
				end
			end,
		})
	end,
}
