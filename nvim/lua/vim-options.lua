vim.g.mapleader = " "
vim.g.airline_theme = "catppuccin"
vim.g.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = "left"
vim.g.python3_host_prog = "python"
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.exrc = true
vim.o.wrap = false
vim.o.relativenumber = true
vim.o.hidden = true
vim.o.errorbells = false
vim.o.nu = true
vim.o.scrolloff = 10
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = "/home/felipe/.vim/undodir"
vim.o.undofile = true
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.o.numberwidth = 1
vim.o.mouse = "a"
vim.o.cursorline = true
vim.opt.nrformats:append("alpha")
vim.opt.diffopt:append("vertical")
vim.o.linebreak = true
vim.opt.iskeyword:remove({"-", "_"})
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.foldenable = false
