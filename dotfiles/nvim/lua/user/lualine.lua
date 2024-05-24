local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
  require("lualine").setup {
    options = {
      disabled_filetypes = { "alpha", "dashboard" },
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = {},
      lualine_b = { "branch" },
      lualine_c = { "diagnostics" },
      lualine_d = { "aerial" },
      lualine_x = { "copilot", "filetype" },
      lualine_y = { "location", "progress" },
      lualine_z = {},
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
