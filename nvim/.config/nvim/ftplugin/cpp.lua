if vim.fn.getfsize(vim.fn.expand("%")) ~= -1 then
  return
end

local template = vim.fn.stdpath("config") .. "/templates/cpp_template.cpp"
local content = vim.fn.readfile(template)
for i, line in ipairs(content) do
  content[i] = line:gsub("%$%(DATE%)", os.date("%a %d %b %Y %H:%M"))
end

vim.api.nvim_buf_set_lines(0, 0, -1, false, content)

