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
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "⟩",
  precedes = "⟨",
  space = "·",
}
vim.opt.wildignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.autoread = true

-- Folding - use treesitter but start with all folds open
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 99   -- open all folds by default
vim.wo.relativenumber = false

-- Performance optimizations
vim.opt.lazyredraw = false  -- Don't use lazyredraw, it can cause issues with some plugins
vim.opt.synmaxcol = 240     -- Only highlight first 240 columns for performance
vim.opt.updatetime = 250    -- Faster completion (default is 4000ms)
vim.opt.timeoutlen = 300    -- Time to wait for mapped sequences
vim.opt.ttimeoutlen = 10    -- Time to wait for terminal key codes (makes Escape and keys feel instant)

-- LSP diagnostics: update only on InsertLeave to reduce lag while typing
vim.diagnostic.config({
  update_in_insert = false,  -- Don't update diagnostics while typing
})

-- Disable completion and other features in Avante input buffers for better performance
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "AvanteInput", "Avante" },
  callback = function()
    -- Disable native completion
    vim.bo.omnifunc = ""
    vim.bo.completefunc = ""
    -- Disable spell checking which can cause lag
    vim.wo.spell = false
  end,
})
