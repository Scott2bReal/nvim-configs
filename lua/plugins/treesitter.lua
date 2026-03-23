return {
	{
		"nvim-treesitter/nvim-treesitter", -- Robust syntax highlighting
		-- This needs to be updated when we switch to neovim 0.12
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		-- lazy = false,
		opts = {
			-- ensure_installed = "all",
			sync_install = false,
			ignore_install = { "" },
			highlight = {
				enable = true,
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
			local has_treesitter, ts_configs = pcall(require, "nvim-treesitter.configs")
			if not has_treesitter then
				vim.notify("nvim-treesitter.configs not found!", vim.log.levels.ERROR)
				return
			end
			ts_configs.setup(opts)
		end,
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context", -- Show context around cursor
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	config = function(_, opts)
	-- 		local utils = require("utils")
	-- 		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = utils.colors.bg1 })
	-- 		require("treesitter-context").setup(opts)
	-- 	end,
	-- },
}
