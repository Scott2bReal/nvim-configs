local status_ok, vimwiki = pcall(require, "vimwiki")
if not status_ok then
  return
end

vimwiki.setup {
  config = function()
    local l = {}
    l.path = "~/vimwiki"
    l.syntax = "markdown"
    l.ext = ".md"
    vim.g.vimwiki_list = { l }
  end
}
