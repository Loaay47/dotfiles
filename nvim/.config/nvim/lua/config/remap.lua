vim.g.mapleader = " "
vim.g.maplocalleader = "."

--Neotree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<M-a>", "ggVG")
vim.keymap.set("n", "<leader>gs", function()
  vim.cmd("Git")
end)


-- Navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- Add newline
vim.keymap.set("n", "<CR>", "o<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><CR>", "O<Esc>", { noremap = true, silent = true })

--split window
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Prevent 'x' from copying deleted characters to the clipboard
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>nr", ":source ~/.config/nvim/init.lua<CR>", { noremap = true, silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

--split navigation
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move right" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move Up" })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/scripts/tmux-sessionizer.sh<CR>")

-- Buffer navigation
vim.keymap.set("n", "<localleader><Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><Tab>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<localleader>x', ':bp | bd #<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", ":enew<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<localleader>u', ':e #<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<Nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>c", "<cmd>!chmod +x %<CR>", { silent = true })

--Competitive Programming
vim.keymap.set("n", "<localleader>r", "<cmd>CompetiTest run<CR>", { desc = "Compile and run CP file for CP" })
vim.keymap.set("n", "<localleader>rc", "<cmd>CompetiTest receive contest<CR>", { desc = "receive contest" })
vim.keymap.set("n", "<localleader>rp", "<cmd>CompetiTest receive problem<CR>", { desc = "receive problem" })
vim.keymap.set("n", "<localleader>at", "<cmd>CompetiTest add_testcase<CR>", { desc = "Add testcase" })
vim.keymap.set("n", "<localleader>et", "<cmd>CompetiTest edit_testcase<CR>", { desc = "Edit testcase" })

-- Compile & Run
vim.keymap.set("n", "<localleader>n", function()
  require("config.run").compile_and_run()
end, { desc = "Run current file" })

vim.keymap.set("n", "<localleader>u", function()
  require("config.run").close_terminal()
end, { desc = "Close Run Terminal" })

vim.keymap.set("t", "<localleader><Esc>", function()
  vim.cmd("stopinsert")
  vim.cmd("wincmd p")
end, { desc = "Return to code from terminal" })

--gcc for commenting a sigle line
--gc for commenting a selection in visual mode
-- fm for formatting
--gd for going to defination
--<C-o> to return back
-- <leader>rn to rename a variable for entire project
