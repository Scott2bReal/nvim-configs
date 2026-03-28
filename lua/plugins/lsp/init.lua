return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = { "mason-org/mason.nvim" },
		config = function(_, opts)
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

			-- Mason must be set up before mason lsp config
			require("mason").setup(opts)

			-- Make sure required servers are installed
			require("mason-lspconfig").setup({
				ensure_installed = servers,
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
				end

				vim.lsp.enable(server)
			end
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"pmizio/typescript-tools.nvim",
		event = { "BufReadPre", "BufNewFile" },
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		opts = {},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		---@module "mason"
		---@type MasonSettings
		opts = {
			ui = {
				check_outdated_packages_on_open = false,
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				-- Add full Neovim runtime library
				{ path = "lazy.nvim", words = { "LazySpec", "LazyConfig" } },
				-- Add blink.cmp types
				{ path = "blink.cmp", words = { "blink" } },
			},
		},
	},
}
