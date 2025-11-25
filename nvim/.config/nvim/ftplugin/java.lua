vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

local jdtls = require('jdtls')
local root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])

local config = {
  cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
  root_dir = root_dir,
  settings = {
    java = {
      project = {
        sourcePaths = { 'src' }
      }
    }
  }
}

jdtls.start_or_attach(config)

local function find_makefile_dir()
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/Makefile") == 1 or vim.fn.filereadable(dir .. "/makefile") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

local function Compile()
  vim.cmd("silent write")

  local mk_dir = find_makefile_dir()
  if not mk_dir then
    vim.api.nvim_err_writeln("No Makefile found in parent directories")
    return
  end

  local prev = vim.fn.getcwd()
  vim.cmd("cd " .. mk_dir)
  vim.cmd("make")
  vim.cmd("cd " .. prev)

  vim.cmd("cwindow")
end

function Run()
  vim.cmd("silent write")
  local mk_dir = find_makefile_dir()
  if mk_dir then
    local prev = vim.fn.getcwd()
    vim.cmd("cd " .. mk_dir)
    vim.cmd("make run")
    vim.cmd("cd " .. prev)
    return
  end

  -- fallback: run single-file Java without Makefile
  local classname = vim.fn.expand("%:t:r")
  local classfile = classname .. ".class"

  if vim.fn.filereadable(classfile) == 1 then
    print(vim.fn.system("java " .. classname))
  else
    vim.api.nvim_err_writeln("Class not found: " .. classfile)
  end
end

vim.keymap.set("n", "<localleader>c", Compile, { buffer = true, silent = true })
vim.keymap.set("n", "<localleader>r", Run, { buffer = true })

