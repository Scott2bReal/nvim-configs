-- `MiniStarterCurrent` - current item.
-- `MiniStarterFooter` - footer units.
-- `MiniStarterHeader` - header units.
-- `MiniStarterInactive` - inactive item.
-- `MiniStarterItem` - item name.
-- `MiniStarterItemBullet` - units from |MiniStarter.gen_hook.adding_bullet()|.
-- `MiniStarterItemPrefix` - unique query for item.
-- `MiniStarterSection` - section units.
-- `MiniStarterQuery` - current query in active items.

local color_map = {
	MiniStarterHeader = require("rose-pine.palette").leaf,
	MiniStarterQuery = require("rose-pine.palette").pine,
	MiniStarterSection = require("rose-pine.palette").rose,
}

vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("MiniHighlight", { clear = true }),
	pattern = "MiniStarterOpened",
	callback = function()
		for hl, color in pairs(color_map) do
			vim.api.nvim_set_hl(0, hl, { fg = color })
		end
	end,
})

return {
	header = table.concat({
		"   ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█ \n",
		"    █  █▀   ▀  █   █      █  ██ █ █ █ \n",
		"██   █ ██▄▄    █   █ █     █ ██ █ █ █ \n",
		"█ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █ \n",
		"█  █ █ ▀███▀           █  █   ▐    █  \n",
		"█   ██                  █▐        ▀   \n",
		"                        ▐             \n",
		"\n",
	}),
}
