vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("_conform-setup", { clear = true }),
	once = true,
	callback = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				caddy = { "caddy" },
				go = { "goimports" },
				javascript = { "oxfmt" },
				typescript = { "oxfmt" },
				typescriptreact = { "oxfmt" },
				javascriptreact = { "oxfmt" },
				json = { "oxfmt" },
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
		})
	end,
})
