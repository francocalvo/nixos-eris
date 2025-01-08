local M = {
  "mistricky/codesnap.nvim",
  build = "make",
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot into clipboard " },
  },
}

function M.config()
  require("codesnap").setup {
    has_breadcrumbs = true,
    has_line_number = true,
    bg_color = "#d8dee9",
    bg_padding = 50
  }
end

return M
