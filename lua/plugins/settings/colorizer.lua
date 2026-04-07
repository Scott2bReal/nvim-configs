vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("Colorizer-setup", { clear = true }),
	callback = function()
		require("colorizer").setup({
			parsers = {
				css = {
					enable = true,
				},
				names = {
					enable = false,
				},
				tailwind = {
					enable = true,
				},
			},
			filetypes = {
				"*",
				"!markdown",
				"!vimwiki",
			},
		})
	end,
})
