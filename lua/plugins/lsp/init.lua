local servers = {
  "bashls",
  "jsonls",
  "lua_ls",
  "html",
  "eslint",
  "yamlls",
  "oxfmt",
  "oxlint",
}

require("mason").setup({
  ui = {
    check_outdated_packages_on_open = false,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
require("mason-lspconfig").setup({
  ensure_installed = servers
})

require("lazydev").setup()

local handlers = require("plugins.lsp.handlers")
handlers.setup()

for _, server in pairs(servers) do
  local server_opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.settings." .. server)
  if has_custom_opts then
    server_opts = vim.tbl_deep_extend("force", server_opts, server_custom_opts)
    vim.lsp.config(server, server_opts)
    vim.lsp.enable(server)
  else
    vim.lsp.config(server, server_opts)
    vim.lsp.enable(server)
  end
end
