return {
	{
		"f4z3r/gruvbox-material.nvim",
		name = "gruvbox-material",
		lazy = false,
		priority = 1000,
		opts = {
			italics = true, -- enable italics in general
			contrast = "medium", -- set contrast, can be any of "hard", "medium", "soft"
			comments = {
				italics = true, -- enable italic comments
			},
			background = {
				transparent = false, -- set the background to transparent
			},
			float = {
				force_background = false, -- force background on floats even when background.transparent is set
				background_color = nil, -- set color for float backgrounds. If nil, uses the default color set
				-- by the color scheme
			},
			signs = {
				highlight = false, -- whether to highlight signs
			},
			customize = nil, -- customize the theme in any way you desire, see below what this
			-- configuration accepts
		},
	},
	{ "ellisonleao/gruvbox.nvim", lazy = true }, -- Gruvbox colorscheme in Lua
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {

			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			-- overrides = function(colors) -- add/modify highlights
			-- 	return {}
			-- end,
			theme = "lotus", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		},
		config = function()
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	{ "catppuccin/nvim", name = "catpuccin", lazy = true },
}
