local utils = require("utils")

local add_modified_icon = function(buf_nr, label)
	local modified_icon = "●"
	local is_modified = vim.api.nvim_get_option_value("modified", {
		buf = buf_nr,
	})
	if is_modified then
		return require("mini.tabline").default_format(buf_nr, label) .. modified_icon .. " "
	else
		return require("mini.tabline").default_format(buf_nr, label)
	end
end

return {
	tabpage_section = "right",
	format = add_modified_icon,
}
