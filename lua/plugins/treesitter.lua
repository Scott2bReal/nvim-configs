return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local has_rainbow_delimiters, rainbow = pcall(require, "rainbow-delimiters")
			if not has_rainbow_delimiters then
				vim.notify("Failed to load rainbow-delimiters")
				return
			end
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow.strategy["global"],
					vim = rainbow.strategy["local"],
				},
				query = {
					[""] = rainbow.strategy["local"],
					lua = "rainbow-blocks",
					javascript = "rainbow-delimiters-react",
					tsx = "rainbow-parens",
					typescript = "rainbow-parens",
				},
				highlight = {
					-- The order of these determines the order of colors used in buffers
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
					"RainbowDelimiterRed",
				},
			}
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter", -- Robust syntax highlighting
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = "all", -- either "all", "maintained", or a list of languages in a table
			sync_install = false, -- install languages synchronously (only applied to ensure_installed)
			ignore_install = { "" }, -- List of parsers to ignore installing
			highlight = {
				enable = true, -- false would disable entire plugin
				disable = { "" }, -- list of language that will be disabled
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true, disable = { "yaml", "ruby", "html", "css", "sql" } },
			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				-- colors = {}, -- table of hex strings
				-- termcolors = {} -- table of colour name strings
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			autotag = {
				enable = true,
			},
		},
		config = function(_, opts)
			local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end
			treesitter.setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context", -- Show context around cursor
		lazy = true,
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
				-- For all filetypes
				-- Note that setting an entry here replaces all other patterns for this entry.
				-- By setting the 'default' entry below, you can control which nodes you want to
				-- appear in the context window.
				default = {
					"class",
					"function",
					"method",
					"for",
					"while",
					"if",
					"switch",
					"case",
					"interface",
					"struct",
					"enum",
				},
				-- Patterns for specific filetypes
				-- If a pattern is missing, *open a PR* so everyone can benefit.
				tex = {
					"chapter",
					"section",
					"subsection",
					"subsubsection",
				},
				haskell = {
					"adt",
				},
				rust = {
					"impl_item",
				},
				terraform = {
					"block",
					"object_elem",
					"attribute",
				},
				scala = {
					"object_definition",
				},
				vhdl = {
					"process_statement",
					"architecture_body",
					"entity_declaration",
				},
				markdown = {
					"section",
				},
				elixir = {
					"anonymous_function",
					"arguments",
					"block",
					"do_block",
					"list",
					"map",
					"tuple",
					"quoted_content",
				},
				json = {
					"pair",
				},
				typescript = {
					"export_statement",
				},
				yaml = {
					"block_mapping_pair",
				},
			},
			exact_patterns = {
				-- Example for a specific filetype with Lua patterns
				-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
				-- exactly match "impl_item" only)
				-- rust = true,
			},

			-- [!] The options below are exposed but shouldn't require your attention,
			--     you can safely ignore them.

			zindex = 20, -- The Z-index of the context window
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
		},
	},
}
