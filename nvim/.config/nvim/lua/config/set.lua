--Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.guicursor = ""
vim.opt.winborder = "rounded"


--Tab setting & indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
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
vim.opt.inccommand = "split"
-- vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.conceallevel = 2

-- vim fold
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable= true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

--spliting
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.colorcolumn = "80"
