local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = {
    "zbirenbaum/copilot-cmp",
  },
}

function M.config()
  require("copilot").setup {
    panel = {
      keymap = {
        accept = "<CR>",
        jump_prev = "[[",
        jump_next = "]]",
        refresh = "gr",
        open = "<M-CR>",
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
        prev = "<C-a>",
        next = "<C-s>",
        dismiss = "<C-x>",
      },
    },
    filetypes = {
      markdown = true,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    copilot_node_command = "node",
  }

  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<c-s>", ":lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

  -- require("copilot_cmp").setup()
end

return M
