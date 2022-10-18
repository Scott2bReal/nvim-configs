local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("Mason couldn't load")
  return
end

local lspconfig = require("lspconfig")

-- List of installed language servers
local servers = {
  "bashls",
  "jsonls",
  "sumneko_lua",
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
}

mason.setup({
  ui = {
    check_outdated_packages_on_open = false,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require "mason-lspconfig".setup({
  ensure_installed = servers,
})

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("scott.mason.handlers").on_attach,
    capabilities = require("scott.mason.handlers").capabilities,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "scott.mason.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
