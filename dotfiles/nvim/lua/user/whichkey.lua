local M = {
  "folke/which-key.nvim",
}

function M.config()
  local which_key = require "which-key"
  which_key.setup {
    defaults = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
    },
    spec = {
      { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
      { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
      { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
      { "<leader>c", "<cmd>bdelete!<CR>", desc = "Close Buffer" },

      { "<leader>l", group = "LSP" },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format {
            async = true,
            filter = function(client)
              return client.name ~= "typescript-tools"
            end,
          }
        end,
        desc = "Format",
      },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
      {
        "<leader>lj",
        function()
          vim.diagnostic.goto_next()
        end,
        desc = "Next Diagnostic",
      },
      {
        "<leader>lh",
        function()
          require("user.lspconfig").toggle_inlay_hints()
        end,
        desc = "Hints",
      },
      {
        "<leader>lk",
        function()
          vim.diagnostic.goto_prev()
        end,
        desc = "Prev Diagnostic",
      },
      {
        "<leader>ll",
        function()
          vim.lsp.codelens.run()
        end,
        desc = "CodeLens Action",
      },
      {
        "<leader>lq",
        function()
          vim.diagnostic.setloclist()
        end,
        desc = "Quickfix",
      },
      {
        "<leader>lr",
        function()
          vim.lsp.buf.rename()
        end,
        desc = "Rename",
      },
      {
        "<leader>la",
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "Code Action",
        mode = { "n", "v" },
      },

      { "<leader>p", group = "Plugins" },
      { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha" },

      { "<leader>s", group = "Aerial" },
      { "<leader>ss", "<cmd>AerialToggle<cr>", desc = "Open right pane" },
      { "<leader>sa", "<cmd>AerialOpen<cr>", desc = "Open floating window" },

      { "<leader>m", group = "Tab" },
      { "<leader>mw", "<cmd>tabnew | terminal<CR>", desc = "Term" },
      { "<leader>mn", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
      { "<leader>mN", "<cmd>tabnew %<cr>", desc = "New Tab" },
      { "<leader>mo", "<cmd>tabonly<cr>", desc = "Only" },
      { "<leader>mh", "<cmd>-tabmove<cr>", desc = "Move Left" },
      { "<leader>ml", "<cmd>+tabmove<cr>", desc = "Move Right" },

      { "<leader>t", group = "Terminal" },
      { "<leader>t1", ":1ToggleTerm<cr>", desc = "1" },
      { "<leader>t2", ":2ToggleTerm<cr>", desc = "2" },
      { "<leader>t3", ":3ToggleTerm<cr>", desc = "3" },
      { "<leader>t4", ":4ToggleTerm<cr>", desc = "4" },
      {
        "<leader>tn",
        function()
          _NODE_TOGGLE()
        end,
        desc = "Node",
      },
      {
        "<leader>tu",
        function()
          _NCDU_TOGGLE()
        end,
        desc = "NCDU",
      },
      {
        "<leader>tt",
        function()
          _HTOP_TOGGLE()
        end,
        desc = "Htop",
      },
      {
        "<leader>tp",
        function()
          _PYTHON_TOGGLE()
        end,
        desc = "Python",
      },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },

      { "<leader>T", group = "Testing" },
      {
        "<leader>Tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Test Nearest",
      },
      {
        "<leader>Tf",
        function()
          require("neotest").run.run(vim.fn.expand "%")
        end,
        desc = "Test File",
      },
      {
        "<leader>Td",
        function()
          require("neotest").run.run { strategy = "dap" }
        end,
        desc = "Debug Test",
      },
      {
        "<leader>Ts",
        function()
          require("neotest").run.stop()
        end,
        desc = "Test Stop",
      },
      {
        "<leader>Ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach Test",
      },

      { "<leader>w", group = "Vimwiki" },
      { "<leader>ww", "<cmd>VimwikiIndex<CR>", desc = "Open Personal Wiki" },
      { "<leader>wi", "<cmd>VimwikiUISelect<CR>", desc = "Open wikis index" },
      { "<leader>wd", group = "Open diary index" },
      { "<leader>wD", "<cmd>VimwikiDiaryGenerateLinks<CR>", desc = "Update links in diary" },
      { "<leader>wn", group = "New entry on diary" },
      { "<leader>wX", "<cmd>VimwikiDeleteFile<CR>", desc = "Delete current file" },
      { "<leader>wr", "<cmd>VimwikiRenameFile<CR>", desc = "Rename current file" },
      { "<leader>wb", "<cmd>VimwikiGoBackLink<CR>", desc = "Go to backlink" },
      { "<leader>wH", "<cmd>:Vimwiki2HTMLBrowse<CR>", desc = "Convert to HTML and open it" },

      { "<leader>g", group = "Git" },
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
      {
        "<leader>gj",
        function()
          require("gitsigns").next_hunk { navigation_message = false }
        end,
        desc = "Next Hunk",
      },
      {
        "<leader>gk",
        function()
          require("gitsigns").prev_hunk { navigation_message = false }
        end,
        desc = "Prev Hunk",
      },
      {
        "<leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>gl",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Blame",
      },
      {
        "<leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer",
      },
      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "<leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk",
      },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },

      { "<leader>f", group = "Find" },
      { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
      { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      {
        "<leader>fp",
        function()
          require("telescope").extensions.projects.projects()
        end,
        desc = "Projects",
      },
      { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File" },

      { "<leader>bb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Find" },
    },
  }
end

return M
