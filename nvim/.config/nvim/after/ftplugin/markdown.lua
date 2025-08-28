vim.opt_local.wrap = true
vim.opt_local.linebreak = true

vim.keymap.set("n", "<leader>pf", ":ObsidianQuickSwitch<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>wn", ":ObsidianOpen<CR>", { buffer = true, silent = true })
vim.keymap.set("n", "<leader>wm", ":ObsidianTemplate<CR>", { buffer = true, silent = true })

vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0, -- only this buffer
  callback = function()
    pcall(vim.treesitter.highlighter.hl_reset, vim.treesitter.highlighter)
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
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
})



--[[
local file_watcher
local reload_timer

local function reload()
  vim.schedule(function()
    if vim.api.nvim_buf_get_option(0, "modified") then
      return
    end
    vim.cmd("edit!")
    print("Buffer reloaded due to external change")
  end)
end

local function start_watcher()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then return end

  if file_watcher then
    file_watcher:stop()
    file_watcher:close()
  end

  file_watcher = vim.uv.new_fs_event()
  file_watcher:start(file_path, {}, function(err)
    if err then
      print("File watch error: " .. err)
      return
    end

    -- debounce: cancel previous timer if it exists
    if reload_timer then
      reload_timer:stop()
      reload_timer:close()
    end

    reload_timer = vim.uv.new_timer()
    reload_timer:start(100, 0, function()  -- 100ms delay
      reload()
      reload_timer:stop()
      reload_timer:close()
      reload_timer = nil
    end)
  end)
end

start_watcher()
 ]]
