vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Markdown shortcuts
vim.keymap.set("n", "<leader>to", function()
	local line_nr = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.fn.getline(line_nr)
	local new_line = nil

	if line:match("%- %[ %]") then
		new_line = line:gsub("%- %[ %]", "- [x]")
	elseif line:match("%- %[x%]") then
		new_line = line:gsub("%- %[x%]", "- [ ]")
	end

	if new_line then
		vim.fn.setline(line_nr, { new_line })
	end
end)

--[[ vim.api.nvim_create_autocmd("BufEnter", {
	buffer = 0, -- only this buffer
	callback = function()
		pcall(vim.treesitter.highlighter.hl_reset, vim.treesitter.highlighter)
	end,
}) ]]

--[[ vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*:[vV\x16]*",
	callback = function()
		vim.cmd("TSBufDisable highlight")
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "[vV\x16]*:*",
	callback = function()
		vim.cmd("TSBufEnable highlight")
	end,
}) ]]

vim.keymap.set("n", "<leader>wl", function()
	local line = vim.api.nvim_get_current_line()
	local col = vim.fn.col(".")
	local char = line:sub(col, col)

	if char == "|" or line:sub(col - 1, col - 1) == "|" then
		local insert_pos = (char == "|") and col or col
		local new_line = line:sub(1, insert_pos) .. " ✅" .. line:sub(insert_pos + 4)
		vim.api.nvim_set_current_line(new_line)
		vim.fn.cursor(0, insert_pos + 4)
	end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>w;", function()
	local line = vim.api.nvim_get_current_line()
	if line:find("false") then
		line = line:gsub("false", "true", 1)
	elseif line:find("true") then
		line = line:gsub("true", "false", 1)
	end
	vim.api.nvim_set_current_line(line)
end, { noremap = true, silent = true })
