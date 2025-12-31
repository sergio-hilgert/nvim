vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- ============================================================================
-- Vim Options
-- ============================================================================

vim.wo.relativenumber = false
vim.o.autoread = true
vim.opt.termguicolors = true
vim.o.updatetime = 1000

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

-- ============================================================================
-- Rails Projections (for vim-rails alternate file navigation)
-- ============================================================================

vim.g.rails_projections = {
  ["app/controllers/*_controller.rb"] = {
    alternate = "spec/requests/{}_spec.rb",
  },
  ["spec/requests/*_spec.rb"] = {
    alternate = "app/controllers/{}_controller.rb",
  },
}

-- ============================================================================
-- Terminal Autocommands
-- ============================================================================

vim.cmd([[
  autocmd TermOpen * startinsert
]])

vim.cmd([[
  autocmd TermClose * quit
]])
