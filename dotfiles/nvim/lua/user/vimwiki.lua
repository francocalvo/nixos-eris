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
      path = "/Users/francocalvo/draftea/notes/",
      syntax = "markdown",
      ext = ".md",
      auto_toc = 1,
      index = "README",
      link_space_char = "_",
      automatic_nested_syntaxes = 1,
      auto_tags = 1,
    },

    {
      path = "/Users/francocalvo/facultad/",
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
