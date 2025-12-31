-- LSP configs (provides base configurations for language servers)
return {
  "neovim/nvim-lspconfig",
  -- lazy = false, -- Must load early so lsp/ configs are available for vim.lsp.enable()
  config = function()
    require "configs.lspconfig"
  end,
}

