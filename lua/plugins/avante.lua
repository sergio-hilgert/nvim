return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    windows = {
      chat = {
        type = "float",
        position = "right",
        size = 40,
      },
    },
    provider = "claude",
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "o4-mini", -- your desired model (or use gpt-4o, etc.)
        extra_request_body = {
          temperature = 0.45,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          reasoning_effort = "high", -- low|medium|high, only used for reasoning models
        },
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-opus-4-5-20251101",
        timeout = 30000, -- Timeout in milliseconds
        context_window = 200000,
        extra_request_body = {
          temperature = 0.45,
          max_tokens = 30000,
        },
      },
    },
    -- Disable features that can cause input lag
    hints = { enabled = false },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- The below dependencies are optional - only load what you need
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    --"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
        -- Disable render-markdown in input areas to reduce lag
        render_modes = { "n", "c" }, -- Only render in normal and command mode, not insert
      },
      ft = { "markdown", "Avante" },
    },
  },
}
