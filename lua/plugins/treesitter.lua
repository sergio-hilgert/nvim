return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim", "lua", "vimdoc",
      "html", "css", "ruby", "typescript", "terraform", "markdown", "markdown_inline"
    },
    -- Enable treesitter-based indentation for better language-aware indenting
    indent = {
      enable = true,
    },
  },
}
