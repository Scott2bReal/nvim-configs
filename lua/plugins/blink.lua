return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      default = {
        'lsp', 'path', 'buffer'
      },
      providers = {
        lsp = {
          fallbacks = {}
        }
      }
    },
    keymap = {
      preset = "default",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<cr>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" }
    },
  },
  build = "cargo build --release"
}
