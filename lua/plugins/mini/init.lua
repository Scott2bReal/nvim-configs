local enabled_plugins = {
	"notify",
	"files",
	"icons",
	"pairs",
	"tabline",
	"bufremove",
	"comment",
}

return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
	config = function()
		for _, name in pairs(enabled_plugins) do
			local has_custom_opts, opts = pcall(require, "plugins.mini.modules." .. name)
			if has_custom_opts then
				require("mini." .. name).setup(opts)
			end

			require("mini." .. name).setup()
		end
	end,
}
