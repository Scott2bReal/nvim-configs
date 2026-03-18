return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre" },
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
