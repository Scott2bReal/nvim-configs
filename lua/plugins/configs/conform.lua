require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
	},
	format_after_save = {
		lsp_format = "fallback",
	},
})
