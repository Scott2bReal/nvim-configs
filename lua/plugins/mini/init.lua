local enabled_modules = {
	"bracketed",
	"bufremove",
	"comment",
	"cursorword",
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
		for _, module in pairs(enabled_modules) do
			local has_custom_opts, custom_opts = pcall(require, "plugins.mini.modules." .. module)
			if has_custom_opts then
				require("mini." .. module).setup(custom_opts)
			else
				require("mini." .. module).setup()
			end
		end
	end,
}
