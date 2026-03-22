return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- TypeScript/JavaScript
      "typescript-language-server",
      "eslint-lsp",
      "prettier",

      -- Lua
      "lua-language-server",
      "stylua",

      -- Ruby
      "rubocop",
      "ruby-lsp",

      -- Terraform
      "terraform",
      "terraform-ls",
      "tflint"
    },
  },
}

