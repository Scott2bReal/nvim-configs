local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	vim.notify("Lsp Installer couldn't load")
	return
end

local lspconfig = require("lspconfig")

-- List of installed language servers
local servers = {
  "bashls",
	"jsonls",
	"sumneko_lua",
	"pyright",
	"solargraph",
	"html",
	"sqlls",
	"tsserver",
	"clangd",
	"cmake",
	"cssls",
  "taplo",
  "yamlls",
  "rust_analyzer",
}

lsp_installer.setup({
	ensure_installed = servers,

  -- Whether to automatically check for outdated servers when opening the UI window.
  ui = { check_outdated_servers_on_open = false }
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("scott.lsp.handlers").on_attach,
		capabilities = require("scott.lsp.handlers").capabilities,
	}

	local has_custom_opts, server_custom_opts = pcall(require, "scott.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end
