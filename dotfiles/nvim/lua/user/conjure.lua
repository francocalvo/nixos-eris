local M = {
  "Olical/conjure",
  ft = { "scheme" },
  dependencies = {
    "PaterJason/cmp-conjure",
    lazy = true,
    config = function()
      local cmp = require "cmp"
      local config = cmp.get_config()
      table.insert(config.sources, { name = "conjure" })
      return cmp.setup(config)
    end,
  },
}

M.lazy = true

return M
