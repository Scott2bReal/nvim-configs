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

-- Use a protected call so no error on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	vim.notify("Lazy couldn't load")
	return
end

-- Plugins!
local plugins = {
	-- General/dependency plugins
	"folke/lazy.nvim", -- Lazy manages itself
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim
	"nvim-lua/plenary.nvim", -- Lua functions required by many plugins
	"kyazdani42/nvim-web-devicons", -- Icons required by many plugins
	"famiu/bufdelete.nvim", -- Makes sure BDelete won't exit neovim
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	"arithran/vim-delete-hidden-buffers", -- Close all buffers but current
	"MunifTanjim/nui.nvim", -- UI Plugin

	-- Alpha
	"goolord/alpha-nvim", -- Dashboard

	-- Autopairs
	"windwp/nvim-autopairs", -- Auto close stuff like "" or ()

	-- Autotags
	"windwp/nvim-ts-autotag", -- Finish tags

	-- Bufferline
	"akinsho/bufferline.nvim", -- List buffers like tabs at the top of the screen

	-- ChatGPT
	"jackMort/ChatGPT.nvim", -- In-Editor ChatGPT client

	-- Colorschemes
	"ellisonleao/gruvbox.nvim", -- Gruvbox colorscheme in Lua
	-- use "luisiacc/gruvbox-baby" -- Gruvbox variation w/ treesitter support
	{
		"wittyjudge/gruvbox-material.nvim",
		priority = 1000,
		lazy = false,
	},
	-- use "sainnhe/gruvbox-material"
	"rebelot/kanagawa.nvim",
	{ "catppuccin/nvim", name = "catpuccin" },

	-- Colorizer
	-- Preview colors in-file. Lazy load, enable with :ColorizerToggle
	"norcalli/nvim-colorizer.lua",
	-- use { "norcalli/nvim-colorizer.lua", opt = true, cmd = { "ColorizerToggle" } }

	-- Comment
	"numToStr/Comment.nvim", -- Easily comment lines
	"JoosepAlviste/nvim-ts-context-commentstring", -- requires treesitter

	-- Completion Plugins
	"hrsh7th/nvim-cmp", -- Completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"hrsh7th/cmp-nvim-lua", -- nvim lua config completion
	"hrsh7th/cmp-nvim-lsp", -- use lsp for completion
	"saadparwaiz1/cmp_luasnip", --snippet completion

	--- Copilot
	-- use "github/copilot.vim" -- AI Code Generation
	"zbirenbaum/copilot.lua",
	-- use "zbirenbaum/copilot-cmp"

	-- DAP
	-- use "mfussenegger/nvim-dap" -- Debug Adapter Protocol client
	-- use "suketa/nvim-dap-ruby" -- Ruby configs for DAP

	-- Fidget
	{ "j-hui/fidget.nvim", tag = "legacy" }, -- Progress indicator for LSP loading

	-- Gitsigns
	"lewis6991/gitsigns.nvim", -- Shows git indicators on each line

	-- Import Cost
	{ "barrett-ruth/import-cost.nvim", build = "sh install.sh npm" }, -- Shows the size of an import

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
	"simrat39/rust-tools.nvim", -- specialized rust tools - installs rust-analyzer by default

	-- Markdown --
	-- In-vim markdown preview (Glow)
	--[[ use { "ellisonleao/glow.nvim", branch = 'main' } ]]
	-- Preview in browser
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- use { 'iamcco/markdown-preview.nvim',
	--   ft = "markdown",
	--   run = 'cd app && npm install',
	--   cmd = 'MarkdownPreview' }

	-- Quickfix window
	-- use {'kevinhwang91/nvim-bqf'}

	-- Neoscroll
	"karb94/neoscroll.nvim", -- Smooth scrolling

	-- NvimTree
	-- use "kyazdani42/nvim-tree.lua" -- File explorer (<leader>e)

	-- NeoTree
	-- Unless you are still migrating, remove the deprecated commands from v1.x
	{
		"nvim-neo-tree/neo-tree.nvim", -- File explorer (<leader>e)
		branch = "v2.x",
		init = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},

	-- Project Nvim
	"ahmedkhalf/project.nvim", -- Project management plugin

	-- Snippets
	"L3MON4D3/LuaSnip", -- Snippet engine
	-- use "rafamadriz/friendly-snippets" -- Lots of snipets

	-- Surround
	"kylechui/nvim-surround", -- Surround text with keymaps

	-- Telescope
	"nvim-telescope/telescope.nvim", -- Fuzzy file finder (<leader>f)
	"nvim-telescope/telescope-media-files.nvim", -- Preview images in telescope

	-- Tidy
	"McAuleyPenney/tidy.nvim", -- Remove trailing whitespace and blank lines on file write

	-- ToggleTerm
	"akinsho/toggleterm.nvim", -- Open terminal inside nvim buffer (<C-\>)

	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter", -- Robust syntax highlighting
		build = ":TSUpdate",
	},
	"mrjones2014/nvim-ts-rainbow", -- Color codes closure pairs like () or {}
	"nvim-treesitter/nvim-treesitter-context", -- Show context around cursor

	-- VimWiki
	"vimwiki/vimwiki", -- Personal wiki (<leader>ww)
	"michal-h21/vimwiki-sync", -- Automatically sync vimwiki on open and close

	-- Which-Key
	"folke/which-key.nvim", -- Keybind help popup
}

local opts = {}

lazy.setup(plugins, opts)
