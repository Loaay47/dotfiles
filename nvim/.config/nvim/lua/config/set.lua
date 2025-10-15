--Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.guicursor = ""


--Tab setting & indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.arabicshape = false

-- Set backup
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- vim.o.timeoutlen = 500

-- set search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.conceallevel = 2

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

--spliting
vim.cmd("set splitright")
-- vim.cmd("set nosplitbelow")

vim.opt.colorcolumn = "80"
