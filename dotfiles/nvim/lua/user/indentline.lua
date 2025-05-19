local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
}

function M.config()
  local icons = require "user.icons"

  local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
  }

  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#ff5555" }) -- Red
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f1fa8c" }) -- Yellow
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#6272a4" }) -- Comment-ish Blue/Purple
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#ffb86c" }) -- Orange
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#50fa7b" }) -- Green
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#bd93f9" }) -- Purple
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#8be9fd" }) -- Cyan)
  end)

  vim.g.rainbow_delimiters = { highlight = highlight }

  require("ibl").setup {
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
      },
      buftypes = { "terminal", "nofile" },
    },
    -- char = icons.ui.LineLeft,
    indent = {
      highlight = highlight,
      
      char = icons.ui.LineMiddle,
      tab_char = icons.ui.LineMiddle,
    },

    whitespace = {
      remove_blankline_trail = false,
    },

    scope = { enabled = true },
  }

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
