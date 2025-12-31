return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    git = {
      enable = true,
      ignore = false, -- ❗ do NOT ignore files listed in .gitignore
    },
    filters = {
      dotfiles = false, -- optional: show dotfiles too
      git_ignored = false, -- ❗ also show git-ignored files explicitly
    },
  },
}
