local Terminal = require("toggleterm.terminal").Terminal
local runner = Terminal:new({ direction = "horizontal", close_on_exit = false, hidden = true })

local function run_java()
  local fname = vim.fn.expand("%:p")
  local file = io.open(fname, "r")
  local package_name = ""

  if file then
    for line in file:lines() do
      local match = line:match("^%s*package%s+([%w%.]+)%s*;")
      if match then
        package_name = match
        break
      end
    end
    file:close()
  end

  local class_name = fname:match("([^/]+)%.java$")
  local full_class_name = (package_name ~= "" and package_name .. "." .. class_name) or class_name
  local root_dir = fname:match("(.*/)(com/.*%.java)$")
  root_dir = root_dir or fname:match("(.*/)") or "."

  local cmd = string.format("javac %s && java -cp %s %s", fname, root_dir, full_class_name)

  if not runner:is_open() then runner:toggle() end
  if runner.window and vim.api.nvim_win_is_valid(runner.window) then
    vim.api.nvim_win_set_height(runner.window, 8)
  end

  runner:send(cmd, true) -- ✅ Send without adding extra newline
end

-- vim.keymap.set("n", "<leader>h", run_java, { buffer = true, desc = "Compile & Run Java" })
--

