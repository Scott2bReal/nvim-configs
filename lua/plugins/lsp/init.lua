return {
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
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
		config = function(_, opts)
			-- Change up order or whatever for the whole JS family if need be
			for _, ft in ipairs({
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"json",
			}) do
				opts.formatters_by_ft[ft] = {
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				}
			end

			require("conform").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		opts = {},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
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
			}

			-- Mason must be set up before mason lsp config
			require("mason").setup(opts)

			local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not has_mason_lspconfig then
				vim.notify("Could not load mason lsp config")
				return
			end

			-- Make sure required servers are installed
			mason_lspconfig.setup({
				ensure_installed = servers,
			})

			local has_handlers, handlers = pcall(require, "plugins.lsp.handlers")
			if not has_handlers then
				vim.notify("Could not load custom handlers")
				return
			end
			handlers.setup()

			-- Look for custom server settings
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
}
