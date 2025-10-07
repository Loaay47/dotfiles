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


-- Java lsp config
local jdtls = require("jdtls")
local setup = require("jdtls.setup")

local root_dir = setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml" })
if not root_dir then
  vim.notify("JDTLS: Root directory not found", vim.log.levels.WARN)
  return
end

local home = vim.env.HOME
local workspace = ("%s/.local/share/eclipse/%s"):format(home, vim.fn.fnamemodify(root_dir, ":p:h:t"))

jdtls.start_or_attach({
  cmd = { "jdtls", "-configuration", workspace, "-data", workspace },
  root_dir = root_dir,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = { java = {} },
  init_options = { bundles = {} },
})

