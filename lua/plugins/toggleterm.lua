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
    -- Custom function to set terminal keymaps
    on_open = function(term)
      -- Easy escape from terminal mode with Esc or jk
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = term.bufnr, desc = "Exit terminal mode" })
      -- Navigate away from terminal while it's running
      vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { buffer = term.bufnr, desc = "Move to left window" })
      vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { buffer = term.bufnr, desc = "Move to bottom window" })
      vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { buffer = term.bufnr, desc = "Move to top window" })
      vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { buffer = term.bufnr, desc = "Move to right window" })
    end,
  },
}
