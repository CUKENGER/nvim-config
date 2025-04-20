-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- vim.o.signcolumn = 'auto' -- this is what you seem to be using.
vim.o.signcolumn = 'yes:1' -- will use 3 columns. 
-- vim.o.signcolumn = 'number'

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indent Settings
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Other
vim.opt.scrolloff = 8
vim.opt.wrap = true

vim.opt.termguicolors = true

-- Fillchars
vim.opt.fillchars = {
   vert = "│",
   fold = "⠀",
   eob = " ", -- suppress ~ at EndOfBuffer
   diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
   msgsep = "‾",
   foldopen = "▾",
   foldsep = "│",
   foldclose = "▸",
}


vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

