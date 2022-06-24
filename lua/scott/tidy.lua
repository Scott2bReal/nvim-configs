local status_ok, tidy = pcall(require, "tidy")
if not status_ok then
  vim.notify("Tidy couldn't load")
  return
end

tidy.setup {
  filetype_exclude = { "markdown", "vimwiki", },
}
