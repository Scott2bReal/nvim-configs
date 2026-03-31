local plugins = {
  -- LSP
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/folke/lazydev.nvim",

  -- Everything else
  { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/Saghen/blink.cmp",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/HiPhish/rainbow-delimiters.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/nvim-lualine/lualine.nvim",
}

vim.pack.add(plugins)

require("plugins.mini")

local fzf_lua = require("fzf-lua")
fzf_lua.setup({
  { "telescope" },
  defaults = {
    file_icons = "mini",
  },
  files = {
    cwd_prompt = false,
  },
  oldfiles = {
    cwd_prompt = false,
    include_current_session = true,
  },
  helptags = {
    profile = "ivy",
  },
  live_grep = {
    profile = "ivy",
  },
  ---@diagnostic disable: missing-fields
  previewers = {
    builtin = {
      syntax_limit_b = 100 * 1024, -- 100kb
    },
  },
  ---@diagnostic enable: missing-fields
})

require("plugins.which-key")

require("conform").setup({
  lua = { "stylua" }
})

require("blink.cmp").setup({
  sources = {
    default = {
      "lazydev",
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
      lsp = {
        fallbacks = {},
      },
    },
  },
  keymap = {
    preset = "default",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<cr>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
  },
  fuzzy = {
    prebuilt_binaries = {
      force_version = "1.*"
    }
  }
})

require("plugins.lsp")
require("plugins.treesitter")

require("ibl").setup({
  scope = {
    enabled = false,
  }
})

require("plugins.lualine")
