vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_listsyms = "     X" -- Sets the todo "icons"
vim.g.vimwiki_autowriteall = 1
vim.g.vimwiki_customwiki2html='~/.local/share/nvim/site/pack/packer/start/vimwiki/autoload/vimwiki/customwiki2html.sh'
vim.g.vimwiki_list = {
    {
        path = '~/Nextcloud/Wiki/Personal',
        -- template_path = "~/vimwiki/templates/",
        -- template_ext = ".md",
        -- template_default = "unit",
        syntax = 'markdown',
        ext = '.md',
        auto_toc = 1,
        index = "main",
        link_space_char = "_",
        automatic_nested_syntaxes = 1,
        auto_tags = 1,
  },
  {
        path = "~/Nextcloud/ReactOData/Wiki",
        -- template_path = "~/Nextcloud/ReactOData/Wiki/templates/",
        -- template_ext = ".md",
        -- template_default = "unit",
        syntax = 'markdown',
        ext = '.md',
        auto_toc = 1,
        index = "index",
        link_space_char = "_",
        automatic_nested_syntaxes = 1,
        auto_tags = 1,
  }
}

