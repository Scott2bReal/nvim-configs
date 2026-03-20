local utils = require("plugins.mini.utils")

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

return (function()
	utils.set_hl("MiniTablineModifiedHidden", {
		bg = utils.colors.bg1,
		fg = utils.colors.fg1,
	})
	utils.set_hl("MiniTablineVisible", {
		bg = utils.colors.bg1,
		fg = utils.colors.fg1,
	})
	utils.set_hl("MiniTablineCurrent", {
		bg = utils.colors.bg2,
		fg = utils.colors.green,
	})
	utils.set_hl("MiniTablineModifiedCurrent", {
		bg = utils.colors.bg2,
		fg = utils.colors.green,
	})

	return {
		tabpage_section = "right",
		format = add_modified_icon,
	}
end)()
