return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Only enable modules that don't overlap NvChad core (v2.5)
    bigfile = { enabled = true },
    debug = { enabled = true },
    dim = { enabled = true },
    gh = { enabled = true },
    gitbrowse = { enabled = true },
    image = { enabled = true },
    keymap = { enabled = true },
    layout = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    notify = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    win = { enabled = true },
    words = { enabled = true },
  },
}

