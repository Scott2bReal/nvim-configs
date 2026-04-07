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
