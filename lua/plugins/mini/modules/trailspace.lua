vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	callback = function()
		require("mini.trailspace").trim()
	end,
})
return {}
