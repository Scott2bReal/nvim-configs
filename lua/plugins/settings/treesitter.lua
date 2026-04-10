vim.api.nvim_create_autocmd("UIEnter", {
	group = vim.api.nvim_create_augroup("_treesitter-setup", { clear = true }),
	once = true,
	callback = function()
		--------------
		-- Parsers --
		--------------
		local parsers = {
			"bash",
			"c",
			"caddy",
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

		require("nvim-treesitter").install(parsers)

		local patterns = {}
		for _, parser in ipairs(parsers) do
			local parser_patterns = vim.treesitter.language.get_filetypes(parser)
			for _, pattern in ipairs(parser_patterns) do
				table.insert(patterns, pattern)
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterAutoGroup", { clear = true }),
			pattern = patterns,
			callback = function()
				vim.treesitter.start()
			end,
		})

		------------------------
		-- Rainbow Delimiters --
		------------------------
		local has_rainbow, rainbow = pcall(require, "rainbow-delimiters")
		if not has_rainbow then
			vim.notify("Failed to load rainbow delimiters")
			return
		end
		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = rainbow.strategy["global"],
				vim = rainbow.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
				tsx = "rainbow-parens",
			},
		}
	end,
})
