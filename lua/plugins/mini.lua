local plugins = {
  files = {
    windows = {
      preview = true,
      width_preview = 75,
    }
  },
  pick = {
    mappings = {
      move_down  = '<C-j>',
      move_up    = '<C-k>',
      move_start = '<C-g>',
    },
    options = {
      content_from_bottom = true
    }
  },
  icons = {},
  pairs = {},
  tabline = {},
  bufremove = {},
  comment = {},
  surround = {}
}

return {
  "nvim-mini/mini.nvim",
  event = "VeryLazy",
  config = function()
    for name, opts in pairs(plugins) do
      require("mini." .. name).setup(opts)
    end
  end
}
