return {
  {
    "nvim-cmp",
    -- after the global opts, add a Ruby-only override
    -- config = function(_, _)
    --   local cmp = require("cmp")
    --   -- grab the default list of sources
    --   local default_sources = cmp.get_config().sources
    --
    --   -- override only for Ruby buffers
    --   cmp.setup.filetype("ruby", {
    --     -- filter out luasnip
    --     sources = vim.tbl_filter(function(src)
    --       return src.name ~= "luasnip"
    --     end, default_sources),
    --   })
    -- end,
  },
}
