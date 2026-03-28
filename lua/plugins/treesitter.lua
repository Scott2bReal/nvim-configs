return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local treesitter = require("nvim-treesitter")
			local parsers = {
				"astro",
				"bash",
				"c",
				"css",
				"diff",
				"dockerfile",
				"gitcommit",
				"gitignore",
				"go",
				"html",
				"http",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"jsx",
				"lua",
				"make",
				"markdown",
				"prisma",
				"regex",
				"rst",
				"ruby",
				"rust",
				"scss",
				"ssh_config",
				"sql",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}

			for _, parser in ipairs(parsers) do
				treesitter.install(parser)
			end

			local patterns = {}
			for _, parser in ipairs(parsers) do
				local parser_patterns = vim.treesitter.language.get_filetypes(parser)
				for _, pattern in ipairs(parser_patterns) do
					table.insert(patterns, pattern)
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = patterns,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}
