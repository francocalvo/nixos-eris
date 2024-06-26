local M = {
  "vimwiki/vimwiki",
  dependencies = {
    "itchyny/calendar.vim",
  },
}

M.init = function()
  vim.g.vimwiki_global_ext = 1
  vim.g.vimwiki_listsyms = "     X" -- Sets the todo "icons"
  vim.g.vimwiki_autowriteall = 1

  vim.g.jupytext_enable = 1
  vim.g.jupytext_fmt = "py"

  vim.g.vimwiki_list = {
    {
      path = "~/Nextcloud/Work/54Cuatro/Wiki",
      -- template_path = "~/Nextcloud/ReactOData/Wiki/templates/",
      -- template_ext = ".md",
      -- template_default = "unit",
      syntax = "markdown",
      ext = ".md",
      auto_toc = 1,
      index = "index",
      link_space_char = "_",
      automatic_nested_syntaxes = 1,
      auto_tags = 1,
    },
    {
      path = "/orfeo/sirvana/sirvana-scraper/docs/",
      syntax = "markdown",
      ext = ".md",
      auto_toc = 1,
      index = "README",
      link_space_char = "_",
      automatic_nested_syntaxes = 1,
      auto_tags = 1,
    },
    {
      path = "/orfeo/Reacto/AGEA/docs",
      syntax = "markdown",
      ext = ".md",
      auto_toc = 1,
      index = "README",
      link_space_char = "_",
      automatic_nested_syntaxes = 1,
      auto_tags = 1,
    },
  }
end

return M
