return {
	{
		"vimwiki/vimwiki",
		ft = { "vimwiki", "markdown" },
		opts = {
			config = function()
				local l = {}
				l.path = "~/vimwiki"
				l.syntax = "markdown"
				l.ext = ".md"
				vim.g.vimwiki_list = { l }
			end,
		},
	},
	{ "michal-h21/vimwiki-sync", ft = "vimwiki" },
}
