local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  vim.notify("Error loading rust-tools")
  return
end

rust_tools.setup()
