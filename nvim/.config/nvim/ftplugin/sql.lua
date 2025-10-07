vim.keymap.set("n", "<localleader>c", ":w | !rm test.db && sqlite3 test.db < schema.sql<CR>")
vim.keymap.set("n", "<localleader>r", ":w | !sqlite3 test.db < %<CR>")
