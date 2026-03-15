return {
  { 'neovim/nvim-lspconfig' },
  {
    'mason-org/mason.nvim',
    dependencies = {
      'mason-org/mason-lspconfig.nvim'
    },
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
      local servers = {
        "astro",
        "biome",
        "bashls",
        "jsonls",
        "lua_ls",
        "html",
        "eslint",
        "yamlls",
        "tailwindcss",
        "prismals",
        "taplo",
        "ts_ls",
      }

      local has_mason_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if not has_mason_lspconfig then
        vim.notify("Could not load mason lsp config")
        return
      end

      -- Mason must be set up before mason lsp config
      require('mason').setup(opts)

      -- Make sure required servers are installed
      mason_lspconfig.setup({
        ensure_installed = servers
      })

      local has_handlers, handlers = pcall(require, "plugins.lsp.handlers")
      if not has_handlers then
        vim.notify("Could not load custom handlers")
        return
      end
      handlers.setup()

      -- Look for custom server settings
      for _, server in pairs(servers) do
        local server_opts = {
          on_attach = handlers.on_attach,
          capabilities = handlers.capabilities
        }
        local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.settings." .. server)
        if has_custom_opts then
          server_opts = vim.tbl_deep_extend("force", server_opts, server_custom_opts)
          vim.lsp.config(server, server_opts)
        end
        vim.lsp.enable(server)
      end
    end
  }
}
