local enabled_modules = {
	"files",
	"bufremove",
	"comment",
	"notify",
	"icons",
	"pairs",
	"starter",
	"tabline",
	"trailspace",
}

for _, module in pairs(enabled_modules) do
	local has_custom_opts, custom_opts = pcall(require, "plugins.mini.modules." .. module)
	if has_custom_opts then
		require("mini." .. module).setup(custom_opts)
	else
		require("mini." .. module).setup()
	end
end
