local M = {
  "lervag/vimtex",
}

M.init = function()
  vim.g.vimtex_view_method = "zathura"
  vim.g.vimtex_compiler_method = "latexmk"
  vim.maplocalleader = ","
end

return M
