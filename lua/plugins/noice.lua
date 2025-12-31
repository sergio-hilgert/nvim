return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = require("configs.noice").opts,
  config = function(_, opts)
    require("configs.noice").setup(opts)
  end,
}
