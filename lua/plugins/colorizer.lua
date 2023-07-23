return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		"*",
		"!markdown",
		"!vimwiki",
	},
}
