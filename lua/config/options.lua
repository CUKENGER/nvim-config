-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

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
vim.opt.wrap = false

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
