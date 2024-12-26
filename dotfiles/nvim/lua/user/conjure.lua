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

M.init = function()
  vim.g["conjure#client#scheme#stdio#command"] = "petite"
  vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "> $?"
end

M.lazy = true

return M
