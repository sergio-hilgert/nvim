local M = {}

M.opts = {
  lsp = {
    -- Disable signature help from noice (disabled it in NvChad too)
    signature = {
      enabled = false,
    },
    -- Disable hover from noice to prevent focus stealing
    hover = {
      enabled = true,
      silent = true,  -- Don't show "No information available" messages
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    -- Disable progress to reduce overhead
    progress = {
      enabled = false,
    },
  },

  -- Put Noice command line UI in the middle of the screen
  cmdline = {
    view = "cmdline_popup",
  },

  -- Disable presets that can cause performance issues
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },

  -- Disable some messages that can be annoying
  routes = {
    -- Hide "No information available" messages
    {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    },
    -- Hide "no signature help available" messages
    {
      filter = {
        event = "notify",
        find = "no signature help",
      },
      opts = { skip = true },
    },
    -- Hide written messages
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },

  -- Throttle to reduce CPU usage - increase for better performance
  throttle = 1000 / 20, -- 20 fps (reduced from 30)
}

M.setup = function(opts)
  require("noice").setup(opts)

  -- Make Noice use your current colorscheme (NvChad/base46) by linking to standard UI groups.
  local function apply_noice_hl_links()
    local link = function(from, to)
      vim.api.nvim_set_hl(0, from, { link = to })
    end

    link("NoiceCmdlinePopup", "NormalFloat")
    link("NoiceCmdlinePopupBorder", "FloatBorder")
    link("NoiceCmdlinePopupTitle", "Title")

    link("NoicePopup", "NormalFloat")
    link("NoicePopupBorder", "FloatBorder")

    link("NoiceConfirm", "NormalFloat")
    link("NoiceConfirmBorder", "FloatBorder")

    -- fallback UI bits
    link("NoiceMini", "NormalFloat")
  end

  apply_noice_hl_links()

  -- Re-apply after theme reloads/changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = apply_noice_hl_links,
  })
end

return M
