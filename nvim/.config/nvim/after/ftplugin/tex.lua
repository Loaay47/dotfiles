vim.keymap.set("n", "<leader>lc", ":silent !pdflatex % > /dev/null 2>&1 &<CR>", { buffer = true })
vim.keymap.set("n", "<leader>lv", ":silent !zathura %:r.pdf &<CR>", { buffer = true })


