local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-luacheck.nvim"
  },
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    sources = {
      formatting.prettier,

      formatting.stylua,
      require("none-ls-luacheck.diagnostics.luacheck"),
      formatting.shfmt,
      formatting.google_java_format,
      --diagnostics.shellcheck,

      -- Python
      require("none-ls.formatting.ruff"),
      formatting.black,
      --diagnostics.ruff,
      -- diagnostics.mypy,

      --# C++
      --diagnostics.cpplint,
      --diagnostics.clang_check,
      diagnostics.cppcheck,
      --formatting.clang_format,

      --# NIX
      formatting.nixfmt,
      diagnostics.deadnix,

      --# LaTeX
      --formatting.latexindent.with {
      --  filetypes = { "tex", "bib" },
      --  extra_args = { "-m", "-l=" .. vim.fn.stdpath "config" .. "/lua/user/lsp/settings/latexindent.yaml" },
      --},
      --diagnostics.chktex,

      --# Beancount
      formatting.bean_format,

      --# SQL
      formatting.sqlfluff.with {
        extra_args = { "--dialect", "mysql" }, -- change to your dialect
      },
      formatting.pg_format,
      formatting.sqlfmt,

      --# Markdown
      --[[ diagnostics.markdownlint, ]]
      --[[ formatting.markdownlint, ]]

      --# Terraform
      diagnostics.terraform_validate,
      diagnostics.trivy,
      formatting.terraform_fmt,
    },
  }
end

return M
