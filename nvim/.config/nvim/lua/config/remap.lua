vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- improvements
vim.keymap.set("n", "<leader>e", [[:! ]], { silent = false })
vim.keymap.set({ "n", "i" }, "<C-b>", "<Esc>:t.<CR>", { silent = false })

-- toggling cmds
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>sa", ":DBUIToggle<CR>")
vim.keymap.set("n", "<M-a>", "ggVG")
vim.keymap.set("n", "<M-g>", ":cnext<CR>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<M-p>", ":cprev<CR>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>")

-- Navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("i", "<M-l>", "<Right>")

-- g remap
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

--split window
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>bl", ":e #<CR>", { silent = true })
vim.keymap.set("n", "<leader>b;", ":bp | bd #<CR>", { silent = true })

-- tabs
vim.keymap.set("n", "<leader>.", ":+tabmove<CR>", { silent = true })
vim.keymap.set("n", "<leader>,", ":-tabmove<CR>", { silent = true })

-- windows navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

-- control the size of splits
vim.keymap.set("n", "<M-,>", "<C-w>5>")
vim.keymap.set("n", "<M-.>", "<C-w>5<")
vim.keymap.set("n", "<M-c>", "<C-w>+")
vim.keymap.set("n", "<M-r>", "<C-w>-")

-- Prevent 'x' from copying deleted characters to the clipboard
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- remove idiotic keys
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<Nop>")
vim.keymap.set("ca", "Q", "q")

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

vim.keymap.set("n", "<leader>tm", function()
	local cmp = require("cmp")
	local cfg = cmp.get_config().enabled
	local state = not (type(cfg) == "function" and cfg() or cfg)
	require("cmp").setup.buffer({ enabled = state })
	print("Autocomplete " .. (state and "enabled" or "disabled"))
end)

-- toggle fugitive
local function toggle_fugitive()
    local winids = vim.api.nvim_list_wins()
    for _, id in ipairs(winids) do
        local bufnr = vim.api.nvim_win_get_buf(id)
        if vim.api.nvim_buf_get_name(bufnr):match("fugitive://") then
            vim.api.nvim_win_close(id, false)
            return
        end
    end
    vim.cmd("Git")
end

vim.keymap.set("n", "<leader>gs", toggle_fugitive)

--quickfix
vim.keymap.set("n", "<leader>q", function()
	if vim.fn.getqflist({ winid = 0 }).winid > 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end)

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

-- copy the current path to clipboard
vim.keymap.set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("File path copied: " .. path)
end)

--gcc for commenting a sigle line
--gc for commenting a selection in visual mode
-- nm for formatting
--
