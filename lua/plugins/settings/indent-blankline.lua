vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("_ibl-setup", { clear = true }),
	callback = function()
		require("ibl").setup({
			scope = {
				enabled = false,
			},
		})
	end,
})
