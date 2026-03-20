return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = true,
  cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec" },
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "t" } },
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
    -- Remove open_mapping since we handle it via keys
    hide_numbers = true,
    shade_terminals = false, -- Disable shading for better performance
    shading_factor = 0,
    start_in_insert = true,
    insert_mappings = false, -- Disable insert mappings, we handle via keys
    terminal_mappings = true,
    persist_size = false, -- Don't persist size for better performance
    persist_mode = false, -- Don't persist mode
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
    -- Simplified on_open - only essential keymaps
    on_open = function(term)
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = term.bufnr, noremap = true })
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { buffer = term.bufnr, noremap = true })
      vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { buffer = term.bufnr, noremap = true })
      vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { buffer = term.bufnr, noremap = true })
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { buffer = term.bufnr, noremap = true })
    end,
  },
}
