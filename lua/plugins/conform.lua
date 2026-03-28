return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	event = { "BufWritePre", "BufNewFile" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			caddy = { "caddy" },
		},
		formatters = {
			caddy = {
				command = "caddy",
				args = { "fmt", "-" },
				stdin = true,
			},
		},
		format_after_save = {
			lsp_format = "fallback",
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
				"oxfmt",
				"biome",
				"prettierd",
				"prettier",
				stop_after_first = true,
			}
		end
		require("conform").setup(opts)
	end,
}
