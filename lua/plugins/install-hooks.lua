-- On-update and on-install plugin actions need special handling (for now?)
-- @see https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#hooks
-- @see https://github.com/saghen/blink.cmp/issues/2142
-- @see https://github.com/neovim/neovim/issues/36024
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("blink_update", { clear = true }),
	pattern = "blink.cmp",
	callback = function(e)
		if e.data.kind == "update" or e.data.kind == "install" then
			vim.notify("PackChanged triggered for blink")
			-- Recommended way to access plugin files inside `PackChanged` event
			vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
			-- Build the plugin from source
			vim.cmd("BlinkCmp build")
		end
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("ts_update", { clear = true }),
	pattern = "nvim-treesitter",
	callback = function(e)
		vim.notify("PackChanged triggered for treesitter")
		if e.data.kind == "update" or e.data.kind == "install" then
			vim.cmd.packadd("nvim-treesitter")
			-- Update installed parsers
			vim.cmd("TSUpdate")
		end
	end,
})
