local status_ok, ntags = pcall(require, "nvim-ts-autotag")
if not status_ok then
  return
end

ntags.setup {
  autotag = {
    enable = true,
  }
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)
