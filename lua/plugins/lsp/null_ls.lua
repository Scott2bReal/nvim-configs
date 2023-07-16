return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function(_, _)
    local has_null_ls, null_ls = pcall(require, "null-ls")
    if not has_null_ls then
      vim.notify("null-ls couldn't load")
      return
    end
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    null_ls.setup({
      debug = false,
      formatting.prettier.with({
        extra_args = {},
        extra_filetypes = { "astro" },
      }),
      formatting.stylua,
      formatting.sqlfluff.with({
        extra_args = { "--dialect", "postgres" },
      }),
      formatting.shfmt,
      diagnostics.flake8,
    })
  end
}
