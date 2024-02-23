local M = {
  "folke/which-key.nvim",
}

function M.config()
  local mappings = {
    q = { "<cmd>confirm q<CR>", "Quit" },
    h = { "<cmd>nohlsearch<CR>", "NOHL" },
    v = { "<cmd>vsplit<CR>", "Split" },
    b = { name = "Buffers" },
    d = { name = "Debug" },
    e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    f = { name = "Find" },
    g = { name = "Git", g = { "<cmd>Neogit<CR>", "Neogit" } },
    c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    l = {
      name = "LSP",
      f = {
        "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
        "Format",
      },
      i = { "<cmd>LspInfo<cr>", "Info" },
      j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
      h = { "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
      k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
    },
    p = { name = "Plugins" },
    t = { name = "Test" },
    a = { "<cmd>Alpha<cr>", "Alpha" },
    w = {
      name = "Tab",
      w = { "<cmd>tabnew | terminal<CR>", "Term" },
      n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      N = { "<cmd>tabnew %<cr>", "New Tab" },
      o = { "<cmd>tabonly<cr>", "Only" },
      h = { "<cmd>-tabmove<cr>", "Move Left" },
      l = { "<cmd>+tabmove<cr>", "Move Right" },
    },
    T = { name = "Treesitter" },
  }

  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = true,
        text_objects = false,
        windows = true,
        nav = true,
        z = false,
        g = false,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },

    -- [[ Config for the UI ]]
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  which_key.register(mappings, opts)
end

return M
