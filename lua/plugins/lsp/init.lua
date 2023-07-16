require("plugins.lsp.handlers").setup()
return {
  {
    "neovim/nvim-lspconfig",
    { "folke/neodev.nvim" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    "jose-elias-alvarez/null-ls.nvim",           -- for formatters and linters
    "jose-elias-alvarez/typescript.nvim",        -- special typescript tools
    { "simrat39/rust-tools.nvim", ft = "rust" }, -- specialized rust tools - installs rust-analyzer by default
    { "folke/neodev.nvim",        ft = "lua" },  -- Neovim development tools
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        check_outdated_packages_on_open = false,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      local has_mason, mason = pcall(require, "mason")
      if not has_mason then
        vim.notify("Mason couldn't load")
        return
      end
      local has_typescript, typescript = pcall(require, "typescript")
      if not has_typescript then
        vim.notify("Typescript couldn't load")
        return
      end
      local has_lspconfig, lspconfig = pcall(require, "lspconfig")
      if not has_lspconfig then
        vim.notify("lspconfig couldn't load")
        return
      end
      -- List of installed language servers
      local servers = {
        "astro",
        "bashls",
        "jsonls",
        "lua_ls",
        "pyright",
        "solargraph",
        "html",
        "sqlls",
        "eslint",
        "clangd",
        "cmake",
        "cssls",
        "yamlls",
        "tailwindcss",
        "tsserver",
        "prismals",
        "taplo",
        "rust_analyzer",
        "graphql",
      }

      mason.setup(opts)

      -- Neodev needs to be setup before lspconfig
      local has_neodev, neodev = pcall(require, "neodev")
      if not has_neodev then
        vim.notify("Neodev couldn't load")
        return
      end
      neodev.setup()

      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      for _, server in pairs(servers) do
        local server_opts = {
          on_attach = require("plugins.lsp.handlers").on_attach,
          capabilities = require("plugins.lsp.handlers").capabilities,
        }

        local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.settings" .. server)
        if has_custom_opts then
          server_opts = vim.tbl_deep_extend("force", server_custom_opts, server_opts)
        end

        -- Special typescript tools (from typescript.nvim plugin)
        if server == "tsserver" then
          typescript.setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false,            -- enable debug logging for commands
            go_to_source_definition = {
              fallback = true,        -- fall back to standard LSP definition on failure
            },
            server = server_opts,
          })
          goto continue
        end

        lspconfig[server].setup(server_opts)
        ::continue::
      end
    end,
  },
}
