local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  vim.notify("Colorizer couldn't load")
  return
end

colorizer.setup()
