local ok, util = pcall(require, "lspconfig.util")
if not ok then
  vim.notify("lspconfig.util couldn't load")
  return {}
end

local config = {
  root_dir = util.root_pattern("biome.json", "biome.jsonc"),
  filetypes = {
    "javascript",
    "javascriptreact", 
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
  },
  single_file_support = false, -- Only enable when biome.json is present
}

return config
