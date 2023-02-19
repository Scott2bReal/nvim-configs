local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Error loading Mason")
	return
end

require("scott.mason.configs")
require("scott.mason.handlers").setup()
require("scott.mason.null-ls")
