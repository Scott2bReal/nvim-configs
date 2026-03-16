local add_modified_icon = function(buf_nr, label)
  local modified_icon = "●"
  local is_modified = vim.api.nvim_get_option_value("modified", {
    buf = buf_nr,
  })
  if is_modified then
    return MiniTabline.default_format(buf_nr, label) .. modified_icon .. " "
  else
    return MiniTabline.default_format(buf_nr, label)
  end
end

local plugins = {
  files = {
    windows = {
      preview = true,
      width_preview = 75,
    },
  },
  pick = {
    mappings = {
      move_down = "<C-j>",
      move_up = "<C-k>",
      move_start = "<C-g>",
    },
    options = {
      content_from_bottom = true,
    },
  },
  icons = {},
  pairs = {},
  tabline = {
    tabpage_section = "right",
    format = add_modified_icon,
  },
  bufremove = {},
  comment = {},
  -- indentscope = {
  -- 	predicate = false,
  --    draw = {
  --      delay = 30
  --    }
  -- },
}

return {
  "nvim-mini/mini.nvim",
  event = "VeryLazy",
  config = function()
    local colors = require("gruvbox-material.colors").get(vim.o.background, "medium")
    vim.api.nvim_set_hl(0, "MiniTablineCurrent", { bg = colors.green, fg = colors.bg1 })
    vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { bg = colors.green, fg = colors.bg1 })
    for name, opts in pairs(plugins) do
      require("mini." .. name).setup(opts)
    end
  end,
}
