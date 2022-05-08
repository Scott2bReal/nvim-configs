local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  vim.notify("Impatient couldn't load")
  return
end

impatient.enable_profile()
