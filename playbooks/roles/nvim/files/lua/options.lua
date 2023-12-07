-- nvim config
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.encoding = 'utf-8'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.laststatus = 2
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    -- fold = "⸱",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.undofile = true
vim.wo.signcolumn = 'yes'
vim.o.completeopt = 'menuone,noselect'
--set shell=fish
vim.o.termguicolors = true
vim.opt.mouse = 'a'
-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
-- search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
