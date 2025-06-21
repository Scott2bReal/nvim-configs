local ok, util = pcall(require, "lspconfig.util")
if not ok then
  vim.notify("lspconfig.util couldn't load")
  return {}
end

local config = {
  root_dir = util.root_pattern(
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    "eslint.config.js",
    "eslint.config.cjs",
    "eslint.config.json",
    "eslint.config.yaml",
    "eslint.config.mjs"
  ),
}

return config
