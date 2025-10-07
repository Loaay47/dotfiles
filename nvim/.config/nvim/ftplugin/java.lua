  vim.cmd("compiler javac")

local function Compile()
  vim.cmd("silent write")
  vim.cmd("cd %:p:h")
  vim.cmd("silent make")
  vim.cmd("cd -")
  vim.cmd("cwindow")
end

local function OnError(_, data, _)
  if data then
    local msgs = vim.tbl_filter(function(msg)
      return msg ~= ""
        and not msg:match("^info:")
        and not msg:match("bogus font ascent/descent")
    end, data)
    if #msgs > 0 then
      vim.api.nvim_err_writeln(table.concat(msgs, "\n"))
    end
  end
end

function Run()

  if not (vim.fn.filereadable("Makefile") == 1 or vim.fn.filereadable("makefile") == 1) then

    local classname = vim.fn.expand("%:t:r")
    local classfile = classname .. ".class"
    if vim.fn.filereadable(classfile) == 1 then
      print(vim.fn.system("java " .. classname))
    else
      vim.api.nvim_err_writeln("Class not found: " .. classfile)
    end

  else
    vim.cmd("make run")
  end
end


vim.keymap.set("n", "<localleader>c", Compile, { buffer = true, silent = true })
vim.keymap.set("n", "<localleader>r", Run, { buffer = true })

