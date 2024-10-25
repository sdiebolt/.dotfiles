vim.opt.guicursor = ""

-- Show which line your cursor is on.
vim.opt.cursorline = true

-- Line numbering.
vim.opt.nu = true
vim.opt.relativenumber = true

-- Set tab size.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Smart autoindenting when starting a new line.
vim.opt.smartindent = true

-- Disable wrapping.
vim.opt.wrap = false

-- Set swap file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Enable colors in the TUI.
vim.opt.termguicolors = true

-- Set minimum number of lines above and below cursor.
vim.opt.scrolloff = 8

-- Setup sign column.
vim.opt.signcolumn = "yes"

-- Include "@" in filenames.
vim.opt.isfname:append("@-@")

-- Update time from swap file to disk.
vim.opt.updatetime = 50

-- Color column and text width.
vim.opt.colorcolumn = "89"
vim.opt.textwidth = 88

-- Split window positions.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Do not show editor mode.
vim.opt.showmode = false

vim.g.mapleader = " "
vim.g.maplocalleader = ","
