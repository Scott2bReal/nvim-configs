return {
	{ "folke/lazy.nvim" }, -- Lazy manages itself
	{ "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim
	{ "nvim-lua/plenary.nvim", lazy = true }, -- Lua functions required by many plugins
	{ "kyazdani42/nvim-web-devicons", lazy = true }, -- Icons required by many plugins
	{ "famiu/bufdelete.nvim", lazy = false }, -- Makes sure BDelete won't exit neovim
	{ "antoinemadec/FixCursorHold.nvim", lazy = true }, -- This is needed to fix lsp doc highlight
	{ "arithran/vim-delete-hidden-buffers", lazy = false }, -- Close all buffers but current
	{ "MunifTanjim/nui.nvim", lazy = true }, -- UI Plugin
}
