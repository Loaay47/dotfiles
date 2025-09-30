--[[ -- lua/config/run.lua
local Terminal = require("toggleterm.terminal").Terminal

local runner = nil
local last_cmd = ""
local last_modified = nil

local M = {}

function M.compile_and_run()
  local ft = vim.bo.filetype
  local fname = vim.fn.expand("%:p")
  local cmd = ""
  local run_cmd = ""
  local compiled = false

  local stat = vim.loop.fs_stat(fname)
  if not stat then
    vim.notify("Cannot stat file", vim.log.levels.ERROR)
    return
  end

  local mtime = stat.mtime.sec

  if ft == "c" then
    compiled = (last_cmd ~= "c") or (last_modified ~= mtime)
    cmd = string.format("gcc %s -o /tmp/a.out", fname)
    run_cmd = "/tmp/a.out"
    last_cmd = "c"
  elseif ft == "cpp" then
    compiled = (last_cmd ~= "cpp") or (last_modified ~= mtime)
    cmd = string.format("g++ %s -o /tmp/a.out", fname)
    run_cmd = "/tmp/a.out"
    last_cmd = "cpp"
  elseif ft == "python" then
    compiled = true
    run_cmd = string.format("python3 %s", fname)
    last_cmd = "python"
elseif ft == "java" then
  local file = io.open(fname, "r")
  local package_line = ""
  local package_name = ""

  if file then
    for line in file:lines() do
      package_line = line:match("^%s*package%s+([%w%.]+)%s*;")
      if package_line then
        package_name = package_line
        break
      end
    end
    file:close()
  end

  local class_name = fname:match("([^/]+)%.java$")
  local full_class_name = class_name
  if package_name ~= "" then
    full_class_name = package_name .. "." .. class_name
  end

  compiled = (last_cmd ~= "java") or (last_modified ~= mtime)
  cmd = string.format("javac %s", fname)

  -- get root directory for classpath
  local root_dir = fname:match("(.*/)(com/.*%.java)$")
  root_dir = root_dir or fname:match("(.*/)") or "."

  run_cmd = string.format("java -cp %s %s", root_dir, full_class_name)
  last_cmd = "java"
  elseif ft == "sh" then
    compiled = true
    run_cmd = string.format("bash %s", fname)
    last_cmd = "sh"
  else
    vim.notify("Unsupported filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  last_modified = mtime

  if not runner then
    runner = Terminal:new({
      direction = "horizontal",
      close_on_exit = false,
      hidden = true,
    })
  end


  -- Open terminal if closed
  if not runner:is_open() then
    runner:toggle()
  end

  -- Resize it to 10 lines
  local win_id = runner.window
  if win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_set_height(win_id, 8)
  end

  -- Send commands
  if compiled and cmd ~= "" then
    runner:send(cmd .. " && " .. run_cmd .. "\n")
  else
    runner:send(run_cmd .. "\n")
  end

  -- Focus back to code
  -- Move cursor to terminal window
  vim.defer_fn(function()
    if runner.window and vim.api.nvim_win_is_valid(runner.window) then
      vim.api.nvim_set_current_win(runner.window)
    end
  end, 100)
end

-- Closes terminal if open
function M.close_terminal()
  if runner and runner:is_open() then
    runner:toggle()
  end
end

return M ]]
