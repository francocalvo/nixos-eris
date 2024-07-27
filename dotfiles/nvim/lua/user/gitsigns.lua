local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local icons = require "user.icons"

  require("gitsigns").setup {
    signs = {
      add = {
        text = icons.ui.BoldLineMiddle,
      },
      change = {
        text = icons.ui.BoldLineDashedMiddle,
      },
      delete = {
        text = icons.ui.TriangleShortArrowRight,
      },
      topdelete = {
        text = icons.ui.TriangleShortArrowRight,
      },
      changedelete = {
        text = icons.ui.BoldLineMiddle,
      },
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    update_debounce = 200,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  }
end

return M
