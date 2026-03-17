local autocmd = vim.api.nvim_create_autocmd

-- Enable word wrap and spell checking in git commit messages
autocmd("FileType", {
	group = vim.api.nvim_create_augroup("_git", { clear = true }),
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Enable spell checking and treesitter highlighting for markdown buffers
autocmd("FileType", {
	group = vim.api.nvim_create_augroup("_markdown", { clear = true }),
	pattern = "markdown",
	callback = function(ev)
		vim.opt_local.spell = true
		vim.treesitter.start(ev.buf, "markdown")
	end,
})

-- Equalize window sizes when the terminal is resized
autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("_auto_resize", { clear = true }),
	pattern = "*",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Hide the tabline on the alpha dashboard, restoring it when the buffer is closed
autocmd("User", {
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

-- Reset the cursor to a horizontal bar on exit (prevents block cursor persisting in the terminal)
autocmd("VimLeave", {
	group = vim.api.nvim_create_augroup("_shape", { clear = true }),
	callback = function()
		vim.opt.guicursor = "a:hor10-blinkwait150-blinkoff150-blinkon150"
	end,
})

-- Force filetype detection for .astro files
autocmd({ "BufRead", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("_astro", { clear = true }),
	pattern = "*.astro",
	callback = function()
		vim.opt.filetype = "astro"
	end,
})
