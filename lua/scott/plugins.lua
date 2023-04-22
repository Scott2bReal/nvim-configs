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
  -- General/dependency plugins
  use "wbthomason/packer.nvim"             -- Packer manages itself
  use "nvim-lua/popup.nvim"                -- An implementation of the Popup API from vim
  use "nvim-lua/plenary.nvim"              -- Lua functions required by many plugins
  use "kyazdani42/nvim-web-devicons"       -- Icons required by many plugins
  use "moll/vim-bbye"                      -- Makes sure BDelete won't exit neovim
  use "antoinemadec/FixCursorHold.nvim"    -- This is needed to fix lsp doc highlight
  use "arithran/vim-delete-hidden-buffers" -- Close all buffers but current
  use "MunifTanjim/nui.nvim"               -- UI Plugin

  -- Alpha
  use 'goolord/alpha-nvim' -- Dashboard

  -- Autopairs
  use "windwp/nvim-autopairs" -- Auto close stuff like "" or ()

  -- Autotags
  use "windwp/nvim-ts-autotag" -- Finish tags

  -- Bufferline
  use "akinsho/bufferline.nvim" -- List buffers like tabs at the top of the screen

  -- ChatGPT
  use "jackMort/ChatGPT.nvim" -- In-Editor ChatGPT client

  -- Colorschemes
  use "ellisonleao/gruvbox.nvim" -- Gruvbox colorscheme in Lua
  -- use "luisiacc/gruvbox-baby" -- Gruvbox variation w/ treesitter support
  use "wittyjudge/gruvbox-material.nvim"
  use "rebelot/kanagawa.nvim"
  use { "catppuccin/nvim", as = "catpuccin" }

  -- Colorizer
  -- Preview colors in-file. Lazy load, enable with :ColorizerToggle
  use "norcalli/nvim-colorizer.lua"
  -- use { "norcalli/nvim-colorizer.lua", opt = true, cmd = { "ColorizerToggle" } }

  -- Comment
  use "numToStr/Comment.nvim"                       -- Easily comment lines
  use "JoosepAlviste/nvim-ts-context-commentstring" -- requires treesitter

  -- Completion Plugins
  use "hrsh7th/nvim-cmp"         -- Completion plugin
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "hrsh7th/cmp-nvim-lua"     -- nvim lua config completion
  use "hrsh7th/cmp-nvim-lsp"     -- use lsp for completion
  use "saadparwaiz1/cmp_luasnip" --snippet completion

  --- Copilot
  -- use "github/copilot.vim" -- AI Code Generation
  use "zbirenbaum/copilot.lua"
  -- use "zbirenbaum/copilot-cmp"

  -- DAP
  -- use "mfussenegger/nvim-dap" -- Debug Adapter Protocol client
  -- use "suketa/nvim-dap-ruby" -- Ruby configs for DAP

  -- Fidget
  use "j-hui/fidget.nvim" -- Progress indicator for LSP loading

  -- Gitsigns
  use "lewis6991/gitsigns.nvim" -- Shows git indicators on each line

  -- Impatient
  use 'lewis6991/impatient.nvim' -- Creates cache to speed up loading Lua modules/nvim startup time

  -- Indentline
  use 'lukas-reineke/indent-blankline.nvim' -- Shows line on indents

  -- Lualine
  use 'nvim-lualine/lualine.nvim' -- Status bar, requires web dev icons

  -- LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"              -- enable LSP
  -- use "williamboman/nvim-lsp-installer" -- simple to use langauge server installer - :LspInstallInfo
  use "jose-elias-alvarez/null-ls.nvim"    -- for formatters and linters
  use "jose-elias-alvarez/typescript.nvim" -- special typescript tools
  use "simrat39/rust-tools.nvim"           -- specialized rust tools - installs rust-analyzer by default

  -- Markdown --
  -- In-vim markdown preview (Glow)
  --[[ use { "ellisonleao/glow.nvim", branch = 'main' } ]]
  -- Preview in browser
  -- install without yarn or npm
  use { "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" }, }

  -- use { 'iamcco/markdown-preview.nvim',
  --   ft = "markdown",
  --   run = 'cd app && npm install',
  --   cmd = 'MarkdownPreview' }

  -- Quickfix window
  -- use {'kevinhwang91/nvim-bqf'}

  -- Neoscroll
  use "karb94/neoscroll.nvim" -- Smooth scrolling

  -- NvimTree
  -- use "kyazdani42/nvim-tree.lua" -- File explorer (<leader>e)

  -- NeoTree
  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  use {
    "nvim-neo-tree/neo-tree.nvim", -- File explorer (<leader>e)
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- Project Nvim
  use "ahmedkhalf/project.nvim" -- Project management plugin

  -- Snippets
  use "L3MON4D3/LuaSnip"             -- Snippet engine
  -- use "rafamadriz/friendly-snippets" -- Lots of snipets

  -- Surround
  use 'kylechui/nvim-surround' -- Surround text with keymaps

  -- Telescope
  use "nvim-telescope/telescope.nvim"             -- Fuzzy file finder (<leader>f)
  use "nvim-telescope/telescope-media-files.nvim" -- Preview images in telescope

  -- Tidy
  use "McAuleyPenney/tidy.nvim" -- Remove trailing whitespace and blank lines on file write

  -- ToggleTerm
  use "akinsho/toggleterm.nvim" -- Open terminal inside nvim buffer (<C-\>)

  --Treesitter
  use {
    "nvim-treesitter/nvim-treesitter", -- Robust syntax highlighting
    run = ":TSUpdate",
  }
  use "mrjones2014/nvim-ts-rainbow"             -- Color codes closure pairs like () or {}
  use "nvim-treesitter/nvim-treesitter-context" -- Show context around cursor

  -- VimWiki
  use "vimwiki/vimwiki"         -- Personal wiki (<leader>ww)
  use "michal-h21/vimwiki-sync" -- Automatically sync vimwiki on open and close

  -- Which-Key
  use "folke/which-key.nvim" -- Keybind help popup

  -- Automatically set up configuration after cloning packer.nvim
  -- Always goes after all plugins!
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
