return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	event = { "BufWritePre", "BufNewFile" },
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = (function()
			local T = {}
			T.lua = { "stylua" }
			T.caddy = { "caddy" }
			for _, ft in ipairs({
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"json",
			}) do
				T[ft] = {
					"oxfmt",
					"biome",
					"prettierd",
					"prettier",
					stop_after_first = true,
				}
			end
			return T
		end)(),
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
}
