return {
	{
		"vimwiki/vimwiki",
		config = function()
			local l = {}
			l.path = "~/vimwiki"
			l.syntax = "markdown"
			l.ext = ".md"
			vim.g.vimwiki_list = { l }
			vim.cmd([[set nocompatible]])
			vim.cmd([[filetype plugin on]])
			vim.cmd([[syntax on]])
		end,
	},
	{ "michal-h21/vimwiki-sync" },
}
