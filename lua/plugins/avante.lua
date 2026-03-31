return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    suggestion = {
      debounce = 1000,   -- Increased debounce (ms) to reduce frequent updates
      throttle = 1000,   -- Added throttle to prevent rapid-fire API calls
    },
    windows = {
      chat = {
        type = "split",
        position = "right",
        size = 40,
      },
    },
    behaviour = {
      enable_fastapply = true,  -- Enable Fast Apply feature
      auto_suggestions = false, -- Disabled to stop expensive background API requests
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, google, kagi, brave, or searxng
      proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
    },
    --provider = "claude-code",
    provider = "claude",
    -- {
    --   acp_providers = {
    --     -- ["gemini-cli"] = {
    --     --   command = "gemini",
    --     --   args = { "--experimental-acp" },
    --     --   env = {
    --     --     NODE_NO_WARNINGS = "1",
    --     --     GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
    --     --   },
    --     -- },
    --     ["claude-code"] = {
    --       command = "npx",
    --       args = { "@zed-industries/claude-code-acp" },
    --       env = {
    --         NODE_NO_WARNINGS = "1",
    --         ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
    --       },
    --     },
    --   },
    -- },
    providers = {
      morph = {
        model = "auto",
      },
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "o4-mini", -- your desired model (or use gpt-4o, etc.)
        -- prompt = "",
        extra_request_body = {
          --timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          temperature = 0.35,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          reasoning_effort = "high", -- low|medium|high, only used for reasoning models
        },
      },
      gemini = {
        --model = "gemini-3.1-pro-preview",
        model = "gemini-3-flash-preview",
        timeout = 30000, -- Timeout in milliseconds
        context_window = 1000000, -- 1M token context window
        disable_tools = true,
        extra_request_body = {
          generationConfig = {
            temperature = 0.2,
            maxOutputTokens = 64000, -- 64k maximum output limit for Gemini 3.1 Pro
          },
        },
      },
      claude = {
        api_key_name="ANTHROPIC_API_KEY",
        endpoint = "https://api.anthropic.com",
        model = "claude-opus-4-5-20251101",
        timeout = 30000, -- Timeout in milliseconds
        context_window = 200000,
        support_prompt_caching = true, -- Enabled caching for system prompts and history
        extra_request_body = {
          temperature = 0.45,
          max_tokens = 4096, -- Capped output tokens to prevent budget drain
        },
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "stevearc/dressing.nvim", -- for input provider dressing
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "sindrets/diffview.nvim",
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    --"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    --"zbirenbaum/copilot.lua", -- for providers='copilot'
    -- "folke/snacks.nvim", -- for input provider snacks
    --- The below dependencies are optional,
    -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
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
      },
      ft = { "markdown", "Avante" },
    },
  },
}
