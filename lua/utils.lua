local M = {}

--- Helper which prepends github domain
M.gh = function(x)
	return "https://github.com/" .. x
end

--Load every lua module in the plugins config directory
M.load_plugin_settings = function()
	for _, file in ipairs(vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/settings/*.lua", true, true)) do
		local module = file:match("lua/(.+)%.lua$"):gsub("/", ".")
		require(module)
	end
end

return M
