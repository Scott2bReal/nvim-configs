-- Don't start the next new line with a comment
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("_comment_settings", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})

-- Use just q to close some special buffers
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("_general_settings", { clear = true }),
	pattern = { "help", "man", "lspinfo", "checkhealth", "qf" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
	end,
})

-- Equalize window dimensions when resizing the Vim window
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("_auto_resize", { clear = true }),
	pattern = "*",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Restore the default cursor shape when leaving Neovim
vim.api.nvim_create_autocmd("VimLeave", {
	group = vim.api.nvim_create_augroup("_shape", { clear = true }),
	callback = function()
		vim.opt.guicursor = "a:hor10-blinkwait150-blinkoff150-blinkon150"
	end,
})

-- On-update and on-install plugin actions need special handling (for now?)
-- @see https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#hooks
-- @see https://github.com/saghen/blink.cmp/issues/2142
-- @see https://github.com/neovim/neovim/issues/36024
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("blink_update", { clear = true }),
	pattern = "blink.cmp",
	callback = function(e)
		if e.data.kind == "update" or e.data.kind == "install" then
			print("PackChanged triggered for blink")
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
		print("PackChanged triggered for treesitter")
		if e.data.kind == "update" or e.data.kind == "install" then
			vim.cmd.packadd("nvim-treesitter")
			-- Update installed parsers
			vim.cmd("TSUpdate")
		end
	end,
})
