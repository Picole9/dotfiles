vim.g.mapleader = ' '
vim.g.encoding = 'utf-8'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.keymap.set('n', '<F4>', ':set number! relativenumber!<CR>')
vim.opt.laststatus = 2
vim.opt.fillchars = {eob = ' '}
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
