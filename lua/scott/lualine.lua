local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  vim.notify("Lualine couldn't load")
  return
end

lualine.setup {
  options = {
    theme = 'gruvbox-material',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  }
}
