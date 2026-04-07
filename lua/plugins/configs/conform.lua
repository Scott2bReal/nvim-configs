vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("conform-setup", { clear = true }),
	callback = function()
		require("conform").setup({
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
		})
	end,
})
