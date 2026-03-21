local enabled_plugins = {
	"bracketed",
	"bufremove",
	"comment",
	"notify",
	"files",
	"icons",
	"pairs",
	"tabline",
	"trailspace",
}

return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
	config = function()
		for _, name in pairs(enabled_plugins) do
			local has_custom_opts, custom_opts = pcall(require, "plugins.mini.modules." .. name)
			if has_custom_opts then
				require("mini." .. name).setup(custom_opts)
			else
				require("mini." .. name).setup()
			end
		end
	end,
}
