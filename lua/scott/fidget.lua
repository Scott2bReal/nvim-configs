local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  vim.notify("Fidget.nvim couldn't load")
  return
end

fidget.setup{}
