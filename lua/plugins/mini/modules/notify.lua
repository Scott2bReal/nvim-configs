--- Places the notification window in the lower right corner, above the command line and status line (if present).
local notify_win_config = function()
	local has_statusline = vim.o.laststatus > 0
	local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
	return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
end

return (function()
	local utils = require("plugins.mini.utils")

	utils.set_hl("MiniFilesNormal", { bg = utils.colors.bg2 })
	utils.set_hl("MiniFilesBorder", { bg = utils.colors.bg2 })

	return {
		window = {
			config = notify_win_config(),
		},
	}
end)()
