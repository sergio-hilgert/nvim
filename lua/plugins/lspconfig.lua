-- LSP configs (provides base configurations for language servers)
return {
  "neovim/nvim-lspconfig",
  config = function()
    require "configs.lspconfig"
  end,
}

