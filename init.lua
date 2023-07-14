--[[
██▓ ███▄    █  ██▓▄▄▄█████▓      ██▓     █    ██  ▄▄▄
▓██▒ ██ ▀█   █ ▓██▒▓  ██▒ ▓▒     ▓██▒     ██  ▓██▒▒████▄
▒██▒▓██  ▀█ ██▒▒██▒▒ ▓██░ ▒░     ▒██░    ▓██  ▒██░▒██  ▀█▄
░██░▓██▒  ▐▌██▒░██░░ ▓██▓ ░      ▒██░    ▓▓█  ░██░░██▄▄▄▄██
░██░▒██░   ▓██░░██░  ▒██▒ ░  ██▓ ░██████▒▒▒█████▓  ▓█   ▓██▒
░▓  ░ ▒░   ▒ ▒ ░▓    ▒ ░░    ▒▓▒ ░ ▒░▓  ░░▒▓▒ ▒ ▒  ▒▒   ▓▒█░
 ▒ ░░ ░░   ░ ▒░ ▒ ░    ░     ░▒  ░ ░ ▒  ░░░▒░ ░ ░   ▒   ▒▒ ░
 ▒ ░   ░   ░ ░  ▒ ░  ░       ░     ░ ░    ░░░ ░ ░   ░   ▒
 ░           ░  ░             ░      ░  ░   ░           ░  ░
]]

vim.loader.enable()

local modules = {
	"options",
	"gruvbox-material",
	"keymaps",
	"plugins",
	"colorscheme",
	"lualine",
	"cmp",
	"mason",
	"telescope",
	"treesitter",
	"autopairs",
	"comment",
	"gitsigns",
	"neotree",
	"bufferline",
	"colorizer",
	"whichkey",
	"alpha",
	"project",
	"indentline",
	"surround",
	"tidy",
	"autocommands",
	"ts-autotags",
	"fidget",
	"copilot",
	"import-cost",
}

for _, module in ipairs(modules) do
	local ok, err = pcall(require, "scott." .. module)
	if not ok then
		vim.notify("Error loading scott." .. module .. "\n\n" .. err)
	end
end
