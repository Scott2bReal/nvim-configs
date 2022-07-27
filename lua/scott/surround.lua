local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
  vim.notify("Surround couldn't load")
  return
end

surround.setup({
})
