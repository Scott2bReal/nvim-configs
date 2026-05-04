local gh = require("utils").gh

local plugins = {
	-- LSP
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("mason-org/mason.nvim"),
	gh("folke/lazydev.nvim"),
	gh("yioneko/nvim-vtsls"),

	-- Treesitter
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("HiPhish/rainbow-delimiters.nvim"),

	-- Colorschemes
	{
		src = gh("rose-pine/neovim"),
		name = "rose-pine",
	},

	-- Everything else
	gh("stevearc/conform.nvim"),
	gh("nvim-mini/mini.nvim"),
	gh("ibhagwan/fzf-lua"),
	gh("folke/which-key.nvim"),
	{
		src = gh("Saghen/blink.cmp"),
		version = "v1.10.2",
	},
	gh("lukas-reineke/indent-blankline.nvim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("kylechui/nvim-surround"),
	gh("nvim-lualine/lualine.nvim"),
	gh("zbirenbaum/copilot.lua"),
	gh("catgoose/nvim-colorizer.lua"),
	gh("windwp/nvim-ts-autotag"),
}

require("plugins.install-hooks")

vim.pack.add(plugins)

require("plugins.mini")
require("plugins.lsp")

require("utils").load_plugin_settings()
