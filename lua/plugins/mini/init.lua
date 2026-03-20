local enabled_plugins = {
	"bufremove",
	"comment",
	"notify",
	"files",
	"icons",
	"pairs",
	"tabline",
}

return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
	config = function()
		for _, name in pairs(enabled_plugins) do
			local has_custom_opts, custom_opts = pcall(require, "plugins.mini.modules." .. name)
			if has_custom_opts then
				print("setting up mini." .. name)
				require("mini." .. name).setup(custom_opts)
			else
				require("mini." .. name).setup()
			end
		end
	end,
}
