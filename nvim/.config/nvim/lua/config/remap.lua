vim.g.mapleader = " "
vim.g.maplocalleader = "."

-- improvements

-- toggling cmds
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>sl", ":DBUIToggle<CR>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<M-a>", "ggVG")



--quickfix
vim.keymap.set('n', '<leader>q', function()
 if vim.fn.getqflist({ winid = 0 }).winid > 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end)
vim.keymap.set('n', '<M-n>', ':cnext<CR>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<M-p>', ':cprev<CR>zz', { noremap = true, silent = true })

-- Navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- terminal navigation
local term_buf = nil
vim.keymap.set("n", "<leader>o", function()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    local win = vim.fn.bufwinid(term_buf)
    if win ~= -1 then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  vim.cmd("botright 9split | terminal")
  term_buf = vim.api.nvim_get_current_buf()
  vim.cmd("startinsert")
end)


-- g remap
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })

--split window
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>s;", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>bl", ":e #<CR>", { silent = true })
vim.keymap.set("n", "<leader>b;", ":bp | bd #<CR>", { silent = true })

 -- windows navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")


-- Prevent 'x' from copying deleted characters to the clipboard
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- remove idiotic keys
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<Nop>")

-- prime prime
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--Competitive Programming
vim.keymap.set("n", "<localleader>t", "<cmd>CompetiTest run<CR>")
vim.keymap.set("n", "<localleader>rc", "<cmd>CompetiTest receive contest<CR>")
vim.keymap.set("n", "<localleader>rp", "<cmd>CompetiTest receive problem<CR>")
vim.keymap.set("n", "<localleader>at", "<cmd>CompetiTest add_testcase<CR>")
vim.keymap.set("n", "<localleader>et", "<cmd>CompetiTest edit_testcase<CR>")

-- run lua inline
vim.keymap.set("n", "<leader>l", "<cmd> source %<CR>")
vim.keymap.set("v", "<leader>l", ":lua<CR>")

--gcc for commenting a sigle line
--gc for commenting a selection in visual mode
-- fm for formatting
--gd for going to defination
--<C-o> to return back
