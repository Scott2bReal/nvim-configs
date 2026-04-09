vim.api.nvim_create_autocmd("UIEnter", {
	group = vim.api.nvim_create_augroup("IndentBlanklineSetup", { clear = true }),
	once = true,
	callback = function()
		require("ibl").setup({
			scope = {
				enabled = false,
			},
		})
	end,
})
