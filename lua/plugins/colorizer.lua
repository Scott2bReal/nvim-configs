return {
	"catgoose/nvim-colorizer.lua",
	cmd = "ColorizerToggle",
	opts = {
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
	},
}
