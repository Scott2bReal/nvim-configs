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
						extra_args = {},
						extra_filetypes = { "astro" },
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
	{ "jose-elias-alvarez/typescript.nvim" }, -- special typescript tools
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
			local has_typescript, typescript = pcall(require, "typescript")
			if not has_typescript then
				vim.notify("Typescript couldn't load")
				return
			end
			local has_lspconfig, lspconfig = pcall(require, "lspconfig")
			if not has_lspconfig then
				vim.notify("lspconfig couldn't load")
				return
			end
			-- List of installed language servers
			local servers = {
				"bashls",
				"jsonls",
				"lua_ls",
				"html",
				"sqlls",
				"eslint",
				"cssls",
				"yamlls",
				"tailwindcss",
				"tsserver",
				"taplo",
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

				-- Special typescript tools (from typescript.nvim plugin)
				if server == "tsserver" then
					typescript.setup({
						disable_commands = false, -- prevent the plugin from creating Vim commands
						debug = false, -- enable debug logging for commands
						go_to_source_definition = {
							fallback = true, -- fall back to standard LSP definition on failure
						},
						server = server_opts,
					})
					goto continue
				end

				lspconfig[server].setup(server_opts)
				::continue::
				require("plugins.lsp.handlers").setup()
			end
		end,
	},
}
