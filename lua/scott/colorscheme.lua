local colorscheme = "gruvbox-material"

vim.g.gruvbox_material_palette = "original"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
