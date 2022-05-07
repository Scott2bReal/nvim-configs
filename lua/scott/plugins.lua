local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so no error on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Packer uses a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Plugins!
return packer.startup(function(use)
  -- Plugins go here
  use "wbthomason/packer.nvim" -- Packer manages itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim
  use "nvim-lua/plenary.nvim" -- Lua functions required by many plugins
  use "kyazdani42/nvim-web-devicons"

  -- Autopairs
  use "windwp/nvim-autopairs"

  -- Colorschemes
  use "ellisonleao/gruvbox.nvim" -- Gruvbox colorscheme in Lua
  use "luisiacc/gruvbox-baby" -- Gruvbox variation w/ treesitter support
  use "wittyjudge/gruvbox-material.nvim"

  -- Comment
  use "numToStr/Comment.nvim" -- Easily comment lines
  use "JoosepAlviste/nvim-ts-context-commentstring" -- requires treesitter

  -- Completion Plugins
  use "hrsh7th/nvim-cmp" -- Completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-nvim-lua" -- nvim lua config completion
  use "hrsh7th/cmp-nvim-lsp" -- use lsp for completion
  use "saadparwaiz1/cmp_luasnip" --snippet completion

  -- Gitsigns
  use "lewis6991/gitsigns.nvim"

  -- Lualine
  use 'nvim-lualine/lualine.nvim' -- Status bar, requires web dev icons

  -- Snippets
  use "L3MON4D3/LuaSnip" -- snippet engine
  use "rafamadriz/friendly-snippets" -- snippetssss

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use langauge server installer

  -- NvimTree
  use "kyazdani42/nvim-tree.lua"

  -- VimWiki
  use 'vimwiki/vimwiki'

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- ToggleTerm
  use "akinsho/toggleterm.nvim"

  --Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"

  -- Automatically set up configuration after cloning packer.nvim
  -- Always goes after all plugins!
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
