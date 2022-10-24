local status_ok, packer = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.configs")
require("user.lsp.handlers").setup()
