local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
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
      formatting.shfmt,
      formatting.google_java_format,
      --diagnostics.shellcheck,

      -- Python
      formatting.ruff,
      --diagnostics.ruff,
      diagnostics.mypy,

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
        extra_args = { "--dialect", "postgres" }, -- change to your dialect
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
