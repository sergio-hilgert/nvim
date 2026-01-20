-- Ruby and Rails support
return {
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby", "eruby", "rake", "gemspec", "podspec", "thor" },
    init = function()
      -- Ruby indentation settings for better method chaining
      -- This makes continuation lines align properly
      vim.g.ruby_indent_assignment_style = "variable"
      vim.g.ruby_indent_hanging_elements = 1
      vim.g.ruby_indent_block_style = "do"
    end,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    cmd = {
      "Rails",
      "Rake",
      "A",
      "R",
      "Emodel",
      "Eview",
      "Econtroller",
      "Emigration",
      "Eschema",
      "Einitializer",
      "Elib",
      "Etask",
      "Espec",
      "Eunittest",
    },
  },
}
