return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Global variable to track autocomplete state (true = enabled)
      vim.g.cmp_autocomplete_enabled = true

      -- Function to toggle autocomplete (exposed globally for mappings.lua)
      _G.toggle_cmp_autocomplete = function()
        vim.g.cmp_autocomplete_enabled = not vim.g.cmp_autocomplete_enabled
        if vim.g.cmp_autocomplete_enabled then
          cmp.setup({
            completion = {
              autocomplete = { cmp.TriggerEvent.TextChanged },
            },
          })
          vim.notify("Autocomplete: ON", vim.log.levels.INFO)
        else
          cmp.setup({
            completion = {
              autocomplete = false,
            },
          })
          vim.notify("Autocomplete: OFF", vim.log.levels.INFO)
        end
      end

      -- Create the toggle command
      vim.api.nvim_create_user_command("ToggleAutocomplete", _G.toggle_cmp_autocomplete, {})

      -- Make completion less aggressive
      opts.completion = {
        keyword_length = 3,
        autocomplete = { cmp.TriggerEvent.TextChanged },
      }

      -- Limit the completion window size
      opts.window = {
        completion = cmp.config.window.bordered({
          max_height = 10,
          max_width = 50,
        }),
        documentation = cmp.config.window.bordered({
          max_height = 15,
          max_width = 50,
        }),
      }

      -- Add delay before showing completions
      opts.performance = {
        debounce = 150,
        throttle = 50,
        fetching_timeout = 200,
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
