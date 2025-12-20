vim.cmd("compiler tex")

local function Compile()
	vim.cmd("write")
	vim.cmd("cd %:p:h")
	vim.cmd("silent make")
	vim.cmd("cd -")
	vim.cmd("cwindow")
end

local function OnError(_, data, _)
	if data then
		local msgs = vim.tbl_filter(function(msg)
			return msg ~= "" and not msg:match("^info:") and not msg:match("bogus font ascent/descent")
		end, data)
		if #msgs > 0 then
			vim.api.nvim_err_writeln(table.concat(msgs, "\n"))
		end
	end
end

local function OpenPdf()
	local proc = "zathura"
	local opta = "-c"
	local optb = "~/.config/zathura/synctex"
	local optc = vim.fn.expand("%:p:r") .. ".pdf"
	local optd = "--synctex-forward"
	local opte = vim.fn.line(".") .. ":" .. vim.fn.col(".") .. ":" .. vim.fn.expand("%:p")
	local cmd = { proc, opta, optb, optc, optd, opte }
	vim.fn.jobstart(cmd, {
		on_stderr = OnError,
		detach = true,
	})
end

vim.keymap.set("n", "<localleader>c", Compile, { buffer = true, silent = true })
vim.keymap.set("n", "<localleader>r", OpenPdf, { buffer = true })
vim.keymap.set("n", "<localleader>s", function()
	vim.cmd("luafile " .. vim.fn.stdpath("config") .. "/ftplugin/tex.lua")
end)
print("sourced")
