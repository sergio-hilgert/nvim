return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Make completion less aggressive
      opts.completion = {
        -- Only show completion after typing 3 characters
        keyword_length = 3,
      }

      -- Limit the completion window size
      opts.window = {
        completion = cmp.config.window.bordered({
          max_height = 10,  -- Limit to 10 items visible
          max_width = 50,   -- Limit width
        }),
        documentation = cmp.config.window.bordered({
          max_height = 15,
          max_width = 50,
        }),
      }

      -- Add delay before showing completions (in milliseconds)
      opts.performance = {
        debounce = 150,        -- Wait 150ms after typing before showing completions
        throttle = 50,         -- Minimum time between completion updates
        fetching_timeout = 200,
      }

      -- Limit the number of items shown
      opts.matching = {
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
      }

      -- Configure sources with lower priority and keyword length
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 3, max_item_count = 10 },
        { name = "luasnip", keyword_length = 3, max_item_count = 5 },
        { name = "buffer", keyword_length = 4, max_item_count = 5 },
        { name = "nvim_lua", keyword_length = 3, max_item_count = 5 },
        { name = "path", keyword_length = 2, max_item_count = 5 },
      })

      return opts
    end,
  },
}
