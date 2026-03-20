return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    gh = { enabled = true }, -- Lazy load on demand
    gitbrowse = { enabled = true }, -- Lazy load on demand
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
    scroll = { enabled = true }, -- Disable smooth scroll to reduce input lag
    picker = { enabled = true },
    words = { enabled = false }, -- Disable word highlighting to reduce lag
  },
}

