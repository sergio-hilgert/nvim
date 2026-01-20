return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    gh = { enabled = true },
    gitbrowse = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      filter = function(notif)
        -- Filter out "no signature help available" messages
        if notif.msg and notif.msg:match("No signature help available") then
          return false
        end
        return true
      end,
    },
    notify = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = true },
    scroll = { enabled = true },
    picker = { enabled = true },
    words = { enabled = true },
  },
}

