return {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true }, -- requires treesitter
  {
    "numToStr/Comment.nvim",                                      -- Easily comment lines
    event = "VeryLazy",
    opts = function()
      local status_ok, ts_context_commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      if not status_ok then
        vim.notify("Comment.nvim couldn't load ts_context_commentstring integration")
        return
      end

      return {
        pre_hook = ts_context_commentstring.create_pre_hook(),
      }
    end,
  },
}
