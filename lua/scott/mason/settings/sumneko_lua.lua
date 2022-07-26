return {
  settings = {

    Lua = {
      diagnostics = {
        globals = { "vim", "awesome", "client", "screen", "root", },
        disable = { "lowercase-global", "trailing-space", },
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true),
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
