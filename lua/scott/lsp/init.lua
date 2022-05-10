local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("scott.lsp.null-ls")
require("scott.lsp.configs")
require("scott.lsp.handlers").setup()
