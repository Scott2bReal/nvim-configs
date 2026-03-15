return {
  "nvim-mini/mini.nvim",
  config = function() 
    require("mini.icons").setup()
    require("mini.pick").setup({
      mappings = {
        move_down  = '<C-j>',
        move_up    = '<C-k>',
        move_start = '<C-g>',
      },
      options = {
        content_from_bottom = true
      }
    })
    require("mini.files").setup({
      windows = {
        preview = true,
        width_preview = 75,
      }
    })
    require("mini.pairs").setup()
    require("mini.git").setup()
    require("mini.tabline").setup()
    require("mini.bufremove").setup()
    require("mini.comment").setup()
  end
}
