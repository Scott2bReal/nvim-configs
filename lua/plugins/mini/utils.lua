local M = {}

--- Wrapper to globally set highlight group colors
---@param name string
---@param opts table
---@returns nil
M.set_hl = function(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

M.colors = require("gruvbox-material.colors").get(vim.o.background, "medium")

return M
