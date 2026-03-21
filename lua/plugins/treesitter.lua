return {
	{
		"nvim-treesitter/nvim-treesitter", -- Robust syntax highlighting
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = "all",
			sync_install = false,
			ignore_install = { "" },
			highlight = {
				enable = true,
				disable = { "" },
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true, disable = { "yaml", "ruby", "html", "css", "sql" } },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
		},
		config = function(_, opts)
			local status_ok, treesitter = pcall(require, "nvim-treesitter")
			if not status_ok then
				vim.notify("nvim-treesitter not found!", vim.log.levels.ERROR)
				return
			end
			treesitter.setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context", -- Show context around cursor
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			local utils = require("utils")
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = utils.colors.bg1 })
			require("treesitter-context").setup(opts)
		end,
	},
}
