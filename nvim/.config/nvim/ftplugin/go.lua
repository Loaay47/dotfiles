vim.keymap.set("n", "<localleader>c", ":w | !go build<CR>")
vim.keymap.set("n", "<localleader>r", ":w | !go run %<CR>")
vim.keymap.set("n", "<localleader>t", ":w | !go test<CR>")
