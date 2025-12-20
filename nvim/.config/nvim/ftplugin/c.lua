if vim.bo.filetype == "c" then
	vim.cmd("compiler gcc")
else
	vim.cmd("compiler g++")
end

local function Compile()
	vim.cmd("silent write")
	vim.cmd("cd %:p:h")
	vim.cmd("silent make")
	vim.cmd("cd -")
	vim.cmd("cwindow")
end

function Run()
	if not (vim.fn.filereadable("Makefile") == 1 or vim.fn.filereadable("makefile") == 1) then
		vim.cmd("silent write")
		vim.cmd("cd %:p:h")
		vim.cmd("silent make")
		vim.cmd("cd -")
		vim.cmd("cwindow")
		local exe = vim.fn.expand("%:p:r")
		if vim.fn.filereadable(exe) == 1 then
			print("")
			print("----- program output -----")
			print(vim.fn.system(exe))
		else
			vim.api.nvim_err_writeln("Executable not found: " .. exe)
		end
	else
		vim.cmd("silent write")
		print("")
		print("----- program output -----")
		vim.cmd("make run")
	end
end

vim.keymap.set("n", "<localleader>c", Compile, { buffer = true, silent = true })
vim.keymap.set("n", "<localleader>r", Run, { buffer = true })
