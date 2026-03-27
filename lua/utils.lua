---@class Utils
---@field set_hl fun(name: string, opts: table): nil
---@field colors table
local M = {}

--- Wrapper to globally set highlight group colors
---@param name string
---@param opts table
M.set_hl = function(name, opts)
	return vim.api.nvim_set_hl(0, name, opts)
end

M.colors = require("gruvbox-material.colors").get(vim.o.background, "medium")

return M
