vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local template_path = os.getenv("HOME") .. "/.config/nvim/templates/cpp_template.cpp"
    local file = io.open(template_path, "r")
    if not file then
      vim.notify("Template file not found: " .. template_path, vim.log.levels.ERROR)
      return
    end
    local template_content = file:read("*a")
    file:close()
    local current_date = os.date("%a %d %b %Y %H:%M")
    template_content = template_content:gsub("%$%(DATE%)", current_date)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template_content, "\n"))
  end,
})


local augroup = vim.api.nvim_create_augroup
local LuiGroup = augroup('LuiGroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = LuiGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

