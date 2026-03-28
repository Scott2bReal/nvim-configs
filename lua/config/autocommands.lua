-- Use just q to close some special buffers
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("_general_settings", { clear = true }),
	pattern = { "help", "man", "lspinfo", "checkhealth", "qf" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
	end,
})

-- Wrap and enable spell checking in gitcommit and markdown files
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("_git", { clear = true }),
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Enable spell checking and treesitter in markdown files
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("_markdown", { clear = true }),
	pattern = "markdown",
	callback = function(ev)
		vim.opt_local.spell = true
		vim.treesitter.start(ev.buf, "markdown")
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

-- Hide the tabline when the alpha dashboard is ready, and show it again when leaving the buffer
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("_alpha", { clear = true }),
	pattern = "AlphaReady",
	callback = function()
		vim.opt.showtabline = 0
		vim.api.nvim_create_autocmd("BufUnload", {
			buffer = 0,
			once = true,
			callback = function()
				vim.opt.showtabline = 2
			end,
		})
	end,
})

-- Restore the default cursor shape when leaving Neovim
vim.api.nvim_create_autocmd("VimLeave", {
	group = vim.api.nvim_create_augroup("_shape", { clear = true }),
	callback = function()
		vim.opt.guicursor = "a:hor10-blinkwait150-blinkoff150-blinkon150"
	end,
})

-- Set the filetype to astro for .astro files
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("_astro", { clear = true }),
	pattern = "*.astro",
	callback = function()
		vim.opt.filetype = "astro"
	end,
})
