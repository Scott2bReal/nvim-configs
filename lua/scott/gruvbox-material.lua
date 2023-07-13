vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_material_palette = "material"
vim.opt.background = "dark"

local status_ok, gruvbox_material = pcall(require, "gruvbox-material")
if not status_ok then
	vim.notify("Failed to load gruvbox-material")
	return
end

gruvbox_material.setup()
