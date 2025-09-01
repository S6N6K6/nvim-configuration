-- GENERAL VIM OPTIONS -- 
-- Set some general properties
vim.g.mapleader = ' ' 
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.showmode = false
vim.o.inccommand = 'split'
vim.o.cursorline = true

vim.o.breakindent = true
vim.o.wrap = false

vim.o.confirm = true

-- Tab settings and behavior

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- Work with splits
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "=", "[[<cmd>vertical resize +5<cr>]]")
vim.keymap.set("n", "-", "[[<cmd>vertical resize -5<cr>]]")
vim.keymap.set("n", "+", "[[<cmd>horizontal resize +5<cr>]]")
vim.keymap.set("n", "^", "[[<cmd>horizontal resize -5<cr>]]")

-- Move throught the file quickly

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Text Highlighting when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('my_highlight_yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end
})
