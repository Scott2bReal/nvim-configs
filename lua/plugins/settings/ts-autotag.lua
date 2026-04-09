local autotag_patterns = {
	"html",
	"javascript",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"vue",
	"tsx",
}
vim.api.nvim_create_autocmd("FileType", {
	pattern = autotag_patterns,
	group = vim.api.nvim_create_augroup("nvim-ts-autotag", { clear = true }),
	once = true,
	callback = function()
		require("nvim-ts-autotag").setup()
	end,
})
