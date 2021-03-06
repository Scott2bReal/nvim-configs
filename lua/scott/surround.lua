local status_ok, surround = pcall(require, "surround")
if not status_ok then
  vim.notify("Surround couldn't load")
  return
end

surround.setup {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "sandwich",
  map_insert_mode = true,
  quotes = {"'", '"'},
  brackets = {"(", '{', '['},
  space_on_closing_char = false,
  pairs = {
    nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
    linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } },
  },
  prefix = "s"
}

-- Normal Mode - Sandwich Mode
--     Add surrounding characters. ( visually select then press s<char> or press sa{motion}{char})
--     Provides key mapping to replace surrounding characters.( sr<from><to> )
--     Provides key mapping to delete surrounding characters.( sd<char> )
--     ss repeats last surround command.
