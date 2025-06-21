local ok, util = pcall(require, "lspconfig.util")
if not ok then
  vim.notify("lspconfig.util couldn't load")
  return {}
end

local config = {
  root_dir = util.root_pattern("biome.json"),
}

return config
