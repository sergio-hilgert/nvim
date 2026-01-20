require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.colorcolumn = "120"

-- Indentation settings for better method chaining support
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false  -- Disable cindent as it can interfere with treesitter

-- For continuation lines (method chaining like .where().order())
vim.opt.breakindent = true
vim.opt.showbreak = "  "  -- Visual indicator for wrapped lines

vim.wo.relativenumber = false

-- vim.o.autoread = true
-- vim.o.updatetime = 1000

vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = {
  space = "·",
  tab = "→ ",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
}
vim.opt.wildignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 99   -- open all folds by default
