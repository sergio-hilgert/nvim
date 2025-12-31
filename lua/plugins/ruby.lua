-- Ruby and Rails support
return {
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby", "eruby", "rake", "gemspec", "podspec", "thor" },
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
