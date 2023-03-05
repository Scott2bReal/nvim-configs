local status_ok, mason = pcall(require, "mason")
if not status_ok then
	vim.notify("Mason couldn't load")
	return
end

local typescript_ok, typescript = pcall(require, "typescript")
if not typescript_ok then
	vim.notify("Typescript couldn't load")
	return
end

local lspconfig = require("lspconfig")

-- List of installed language servers
local servers = {
	"astro",
	"bashls",
	"jsonls",
	"lua_ls",
	"pyright",
	"solargraph",
	"html",
	"sqlls",
	"eslint",
	"clangd",
	"cmake",
	"cssls",
	"yamlls",
	"tailwindcss",
	"tsserver",
	"prismals",
	"taplo",
	"rust_analyzer",
}

mason.setup({
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

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("scott.mason.handlers").on_attach,
		capabilities = require("scott.mason.handlers").capabilities,
	}

	local has_custom_opts, server_custom_opts = pcall(require, "scott.mason.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end

	-- Special typescript tools (from typescript.nvim plugin)
	if server == "tsserver" then
		typescript.setup({
			disable_commands = false, -- prevent the plugin from creating Vim commands
			debug = false, -- enable debug logging for commands
			go_to_source_definition = {
				fallback = true, -- fall back to standard LSP definition on failure
			},
			server = opts,
		})
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
