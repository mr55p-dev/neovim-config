-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.hlsearch = true

vim.o.number = true

-- Enable mouse mode
vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.conceallevel = 3
vim.o.cursorline = true
vim.o.backup = false

vim.o.autoread = true
vim.o.autowrite = true

vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.wrap = true

-- Enable folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- vim.o.showmode = false
-- vim.o.cmdheight = 0

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set hidden
vim.o.hidden = true

-- Set tabs
vim.o.autoindent = true
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 0
vim.o.shiftround = true
vim.o.smartindent = true

vim.o.splitbelow = true
vim.o.splitright = true

-- Set sessionoptions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- Set the leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable nord borders
vim.g.nord_borders = true
