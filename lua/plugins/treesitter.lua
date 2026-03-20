return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "vim", "lua", "vimdoc",
      "html", "css", "ruby", "typescript", "terraform", "markdown", "markdown_inline"
    },
    -- Enable treesitter-based indentation for better language-aware indenting
    indent = {
      enable = true,
    },
    -- Optimize highlighting
    highlight = {
      enable = true,
      -- Disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
  },
}
