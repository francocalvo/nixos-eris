local M = {
  "nathangrigg/vim-beancount",
}

M.init = function()
  vim.g.beancount_separator_col = 80
  vim.g.beancount_root = "~/Nextcloud/Finanzas/Beans/main.bean"
  vim.g.vimwiki_autowriteall = 1
  }
end

return M
