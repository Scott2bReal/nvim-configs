local gh = require("utils").gh

local plugins = {
	-- LSP
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("mason-org/mason.nvim"),
	gh("folke/lazydev.nvim"),

	-- Treesitter stuff
	gh("nvim-treesitter/nvim-treesitter"),
	gh("HiPhish/rainbow-delimiters.nvim"),

	-- Everything else
	{
		src = gh("rose-pine/neovim"),
		name = "rose-pine",
	},
	gh("stevearc/conform.nvim"),
	gh("nvim-mini/mini.nvim"),
	gh("ibhagwan/fzf-lua"),
	gh("folke/which-key.nvim"),
	gh("Saghen/blink.cmp"),
	gh("lukas-reineke/indent-blankline.nvim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("kylechui/nvim-surround"),
	gh("nvim-lualine/lualine.nvim"),
}

vim.pack.add(plugins)

require("plugins.mini")
require("plugins.lsp")
require("plugins.treesitter")

-- Simple configs
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
	},
	format_after_save = {
		lsp_format = "fallback",
	},
})

require("ibl").setup({
	scope = {
		enabled = false,
	},
})

-- Auto-load every module in "plugins.configs"
require("utils").load_plugin_configs()
