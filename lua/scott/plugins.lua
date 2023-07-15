-- Automatically install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	vim.notify("Lazy couldn't load")
	return
end

local plugins = {
	-- General/dependency plugins
	"folke/lazy.nvim", -- Lazy manages itself
	{ "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim
	{ "nvim-lua/plenary.nvim", lazy = true }, -- Lua functions required by many plugins
	{ "kyazdani42/nvim-web-devicons", lazy = true }, -- Icons required by many plugins
	{ "famiu/bufdelete.nvim", lazy = false }, -- Makes sure BDelete won't exit neovim
	{ "antoinemadec/FixCursorHold.nvim", lazy = true }, -- This is needed to fix lsp doc highlight
	{ "arithran/vim-delete-hidden-buffers", lazy = false }, -- Close all buffers but current
	{ "MunifTanjim/nui.nvim", lazy = true }, -- UI Plugin

	-- Alpha
	"goolord/alpha-nvim", -- Dashboard

	-- Autopairs
	{ "windwp/nvim-autopairs", event = "InsertEnter" }, -- Auto close stuff like "" or ()

	-- Autotags
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"htmldjango",
			"javascript",
			"javascriptreact",
			"jsx",
			"typescript",
			"typescriptreact",
			"tsx",
			"astro",
			"rescript",
			"svelte",
			"vue",
			"xml",
			"php",
			"markdown",
			"glimmer",
			"handlebars",
			"hbs",
		},
	}, -- Finish tags

	-- Bufferline
	"akinsho/bufferline.nvim", -- List buffers like tabs at the top of the screen

	-- Colorschemes
	{ "ellisonleao/gruvbox.nvim", lazy = true }, -- Gruvbox colorscheme in Lua
	-- use "luisiacc/gruvbox-baby" -- Gruvbox variation w/ treesitter support
	{
		"wittyjudge/gruvbox-material.nvim",
		priority = 1000,
		lazy = false,
	},
	-- use "sainnhe/gruvbox-material"
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catpuccin", lazy = true },

	-- Colorizer
	-- Preview colors in-file. Lazy load, enable with :ColorizerToggle
	"norcalli/nvim-colorizer.lua",
	-- use { "norcalli/nvim-colorizer.lua", opt = true, cmd = { "ColorizerToggle" } }

	-- Comment
	{ "numToStr/Comment.nvim", lazy = true, }, -- Easily comment lines
	"JoosepAlviste/nvim-ts-context-commentstring", -- requires treesitter

	-- Completion Plugins
	{ "hrsh7th/nvim-cmp", event = "InsertEnter" }, -- Completion plugin
	{ "hrsh7th/cmp-buffer", event = "InsertEnter" }, -- buffer completions
	{ "hrsh7th/cmp-path", event = "InsertEnter" }, -- path completions
	{ "hrsh7th/cmp-cmdline", event = "InsertEnter" }, -- cmdline completions
	{ "hrsh7th/cmp-nvim-lua", event = "InsertEnter" }, -- nvim lua config completion
	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" }, -- use lsp for completion
	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" }, --snippet completion

	--- Copilot
	{ "zbirenbaum/copilot.lua", event = "InsertEnter" },

	-- DAP
	-- use "mfussenegger/nvim-dap" -- Debug Adapter Protocol client
	-- use "suketa/nvim-dap-ruby" -- Ruby configs for DAP

	-- Fidget
	{ "j-hui/fidget.nvim", tag = "legacy" }, -- Progress indicator for LSP loading

	-- Gitsigns
	"lewis6991/gitsigns.nvim", -- Shows git indicators on each line

	-- Import Cost
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh npm",
		ft = { "typescript", "typescriptreact", "jsx", "javascript", "javascriptreact", "svelte", "astro", "vue" },
	}, -- Shows the size of an import

	-- Indentline
	"lukas-reineke/indent-blankline.nvim", -- Shows line on indents

	-- Lualine
	"nvim-lualine/lualine.nvim", -- Status bar, requires web dev icons

	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig", -- enable LSP
	-- use "williamboman/nvim-lsp-installer" -- simple to use langauge server installer - :LspInstallInfo
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	"jose-elias-alvarez/typescript.nvim", -- special typescript tools
	{ "simrat39/rust-tools.nvim", ft = "rust" }, -- specialized rust tools - installs rust-analyzer by default

	-- Markdown --
	-- In-vim markdown preview (Glow)
	--[[ use { "ellisonleao/glow.nvim", branch = 'main' } ]]

	-- Preview in browser
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		-- init = function()
		-- 	vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
		-- end,
		ft = { "markdown", "vimwiki" },
	},

	-- NeoTree
	{
		"nvim-neo-tree/neo-tree.nvim", -- File explorer (<leader>e)
		branch = "v2.x",
		-- Unless you are still migrating, remove the deprecated commands from v1.x
		init = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		end,
		module = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
	},

	-- Project Nvim
	"ahmedkhalf/project.nvim", -- Project management plugin

	-- Snippets
	{ "L3MON4D3/LuaSnip", lazy = true }, -- Snippet engine
	-- use "rafamadriz/friendly-snippets" -- Lots of snippets

	-- Surround
	"kylechui/nvim-surround", -- Surround text with keymaps

	-- Telescope
	{ "nvim-telescope/telescope.nvim" }, -- Fuzzy file finder (<leader>f)
	"nvim-telescope/telescope-media-files.nvim", -- Preview images in telescope

	-- Tidy
	{ "McAuleyPenney/tidy.nvim", event = "InsertEnter" }, -- Remove trailing whitespace and blank lines on file write

	-- ToggleTerm
	-- "akinsho/toggleterm.nvim", -- Open terminal inside nvim buffer (<C-\>)

	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter", -- Robust syntax highlighting
		build = ":TSUpdate",
	},
	"mrjones2014/nvim-ts-rainbow", -- Color codes closure pairs like () or {}
	"nvim-treesitter/nvim-treesitter-context", -- Show context around cursor

	-- VimWiki
	{
		"vimwiki/vimwiki",
		config = function()
			local l = {}
			l.path = "~/vimwiki"
			l.syntax = "markdown"
			l.ext = ".md"
			vim.g.vimwiki_list = { l }
		end,
	},

	-- Personal wiki (<leader>ww)
	{ "michal-h21/vimwiki-sync", ft = "vimwiki" }, -- Automatically sync vimwiki on open and close

	-- Which-Key
	"folke/which-key.nvim", -- Keybind help popup
}

local opts = { browser = "firefox" }

lazy.setup(plugins, opts)
