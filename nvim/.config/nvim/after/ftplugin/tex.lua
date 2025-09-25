vim.bo.makeprg = "pdflatex %"
vim.keymap.set("n", "<leader>lc", function()
  vim.cmd("make")
  if vim.fn.getqflist({size=0}).size > 0 then
    vim.cmd("cwindow")
  end
end, { buffer = true, silent = true })

vim.keymap.set("n", "<leader>lv", ":silent !zathura %:r.pdf &<CR>", { buffer = true })

