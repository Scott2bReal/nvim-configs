-- Automatically install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	vim.notify("Lazy couldn't load")
	return
end

lazy.setup({
	spec = {
		import = "plugins",
	},
	install = {
		colorscheme = { "gruvbox-material" },
	},
	browser = "firefox",
	-- disable some rtp plugins
	disabled_plugins = {
		"tutor",
		"gzip",
		"matchit",
		"matchparen",
		"netrwPlugin",
		"tarPlugin",
		"tohtml",
		"tutor",
		"zipPlugin",
	},
})
