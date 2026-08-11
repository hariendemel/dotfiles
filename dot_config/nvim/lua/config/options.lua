vim.cmd.colorscheme("catppuccin")

vim.g.netrw_banner = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.fillchars = { eob = " " }
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.completeopt = "menuone,noselect,fuzzy"
vim.opt.shortmess:append("c")

vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.laststatus = 3

vim.opt.hidden = true
vim.opt.path:append("**")

vim.opt.inccommand = "split"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.updatetime = 250
vim.opt.concealcursor = ""
vim.opt.winborder = "rounded"
