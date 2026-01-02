return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec" },
  keys = {
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal: Float" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal: Horizontal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Terminal: Vertical" },
    { "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Terminal: Tab" },
    { "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", desc = "Terminal: Toggle all" },
    { "<leader>t1", "<cmd>1ToggleTerm<CR>", desc = "Terminal: Toggle #1" },
    { "<leader>t2", "<cmd>2ToggleTerm<CR>", desc = "Terminal: Toggle #2" },
    { "<leader>t3", "<cmd>3ToggleTerm<CR>", desc = "Terminal: Toggle #3" },
    { "<leader>ts", "<cmd>ToggleTermSendCurrentLine<CR>", desc = "Terminal: Send line", mode = "n" },
    { "<leader>ts", "<cmd>ToggleTermSendVisualSelection<CR>", desc = "Terminal: Send selection", mode = "v" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = "rounded",
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.85)
      end,
      winblend = 0,
    },
    winbar = {
      enabled = false,
    },
  },
}

