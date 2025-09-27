local Terminal = require("toggleterm.terminal").Terminal
local runner = Terminal:new({ direction = "horizontal", close_on_exit = false, hidden = true })

local function run_c()
  local fname = vim.fn.expand("%:p")
  local cmd = string.format("gcc %s -o /tmp/a.out && /tmp/a.out", fname)

  if not runner:is_open() then runner:toggle() end
  if runner.window and vim.api.nvim_win_is_valid(runner.window) then
    vim.api.nvim_win_set_height(runner.window, 8)
  end

  runner:send(cmd .. "\n")
end

vim.keymap.set("n", "<localleader>c", run_c, { buffer = true, desc = "Compile & Run C" })

