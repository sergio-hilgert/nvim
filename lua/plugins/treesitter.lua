return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim", "lua", "vimdoc",
      "html", "css", "ruby", "terraform", "markdown", "markdown_inline",
      "typescript", "tsx", "javascript", "jsdoc", "json",
    },
    -- Enable treesitter-based indentation for better language-aware indenting
    indent = {
      enable = true,
    },
  },
}
