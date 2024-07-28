return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function(_, _)
			local has_null_ls, null_ls = pcall(require, "null-ls")
			if not has_null_ls then
				vim.notify("null-ls couldn't load")
				return
			end
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			null_ls.setup({
				debug = false,
				sources = {
					formatting.prettier.with({
						extra_filetypes = { "astro" },
						extra_args = {},
					}),
					formatting.stylua,
					formatting.sqlfluff.with({
						extra_args = { "--dialect", "postgres" },
					}),
					formatting.shfmt,
					diagnostics.flake8,
				},
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{ "folke/neodev.nvim" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "simrat39/rust-tools.nvim", ft = "rust" }, -- specialized rust tools - installs rust-analyzer by default
	{ "folke/neodev.nvim", ft = "lua" }, -- Neovim development tools
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
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
			local has_mason, mason = pcall(require, "mason")
			if not has_mason then
				vim.notify("Mason couldn't load")
				return
			end
			local has_lspconfig, lspconfig = pcall(require, "lspconfig")
			if not has_lspconfig then
				vim.notify("lspconfig couldn't load")
				return
			end
			-- List of installed language servers
			local servers = {
				"astro",
				"bashls",
				-- "cssls",
				"jsonls",
				"lua_ls",
				"pyright",
				"solargraph",
				"html",
				"sqlls",
				"eslint",
				"clangd",
				"cmake",
				"yamlls",
				"tailwindcss",
				"prismals",
				"taplo",
				"rust_analyzer",
				"graphql",
				"stylelint_lsp",
			}

			mason.setup(opts)

			-- Neodev needs to be setup before lspconfig
			local has_neodev, neodev = pcall(require, "neodev")
			if not has_neodev then
				vim.notify("Neodev couldn't load")
				return
			end
			neodev.setup()

			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})

			for _, server in pairs(servers) do
				local server_opts = {
					on_attach = require("plugins.lsp.handlers").on_attach,
					capabilities = require("plugins.lsp.handlers").capabilities,
				}

				local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.settings." .. server)
				if has_custom_opts then
					server_opts = vim.tbl_deep_extend("force", server_custom_opts, server_opts)
				end

				lspconfig[server].setup(server_opts)
				require("plugins.lsp.handlers").setup()
			end
		end,
	},
}
