-- Vim options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.cursorline = true
opt.scrolloff = 8

-- Behavior
opt.autoread = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 50
opt.splitbelow = true
opt.splitright = true

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
