local servers = {
	"astro",
	"biome",
	"bashls",
	"jsonls",
	"lua_ls",
	"html",
	"eslint",
	"yamlls",
	"tailwindcss",
	"prismals",
	"oxfmt",
	"oxlint",
}

require("mason").setup({
	ui = {
		check_outdated_packages_on_open = false,
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	group = vim.api.nvim_create_augroup("lazydev-setup", { clear = true }),
	callback = function()
		require("lazydev").setup()
	end,
})

local ts_patterns = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
vim.api.nvim_create_autocmd("FileType", {
	pattern = ts_patterns,
	group = vim.api.nvim_create_augroup("typescript-tools-setup", { clear = true }),
	callback = function()
		require("typescript-tools").setup({})
	end,
})

local handlers = require("plugins.lsp.handlers")
handlers.setup()

for _, server in pairs(servers) do
	local server_opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

	local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.settings." .. server)
	if has_custom_opts then
		server_opts = vim.tbl_deep_extend("force", server_opts, server_custom_opts)
		vim.lsp.config(server, server_opts)
		vim.lsp.enable(server)
	else
		vim.lsp.config(server, server_opts)
		vim.lsp.enable(server)
	end
end
