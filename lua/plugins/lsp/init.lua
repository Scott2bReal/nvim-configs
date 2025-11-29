return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function(_, _)
			local has_null_ls, null_ls = pcall(require, "null-ls")
			if not has_null_ls then
				vim.notify("null-ls couldn't load")
				return
			end
			local formatting = null_ls.builtins.formatting
			-- local diagnostics = null_ls.builtins.diagnostics
			null_ls.setup({
				debug = false,
				sources = {
					formatting.prettier.with({
						extra_filetypes = { "astro" },
						extra_args = {},
					}),
					-- formatting.biome,
					formatting.stylua,
					formatting.sqlfluff.with({
						extra_args = { "--dialect", "postgres" },
					}),
					formatting.shfmt,
					-- diagnostics.flake8,
				},
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{ "mason-org/mason.nvim" },
	{ "mason-org/mason-lspconfig.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "simrat39/rust-tools.nvim", ft = "rust" }, -- specialized rust tools - installs rust-analyzer by default
	{
		"mason-org/mason.nvim",
		-- build = ":MasonUpdate",
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

			-- List of installed language servers
			local servers = {
				"astro",
				"biome",
				"bashls",
				-- "cssls",
				"jsonls",
				"lua_ls",
				"pyright",
				"html",
				"sqlls",
				"eslint",
				"clangd",
				"yamlls",
				"tailwindcss",
				"prismals",
				"taplo",
				"rust_analyzer",
				"stylelint_lsp",
			}

			mason.setup(opts)

			local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
			if not has_mason_lspconfig then
				vim.notify("Mason LSPconfig couldn't load")
				return
			end

			mason_lspconfig.setup({
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

				vim.lsp.config(server, server_opts)
				require("plugins.lsp.handlers").setup()
			end
		end,
	},
}
