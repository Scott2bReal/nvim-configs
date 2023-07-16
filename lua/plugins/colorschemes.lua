return {
	{
		"wittyjudge/gruvbox-material.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd([[colorscheme gruvbox-material]])
		end,
	},
	{ "ellisonleao/gruvbox.nvim", lazy = true }, -- Gruvbox colorscheme in Lua
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opt = {

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
