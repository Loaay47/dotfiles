vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
	pattern = "*",
	callback = function()
		local save_cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, save_cursor)
	end,
})

vim.o.tabline = "%!v:lua.SimpleTabline()"
function _G.SimpleTabline()
	local s = ""
	for i = 1, vim.fn.tabpagenr("$") do
		local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
		local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
		if name == "" then
			name = "[No Name]"
		end
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel# " .. i .. ": " .. name .. " "
		else
			s = s .. "%#TabLine# " .. i .. ": " .. name .. " "
		end
	end
	return s .. "%#TabLineFill#"
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

-- to shut up errors in dwm config
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "config.h", "config.def.h" },
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 })
  end,
})
