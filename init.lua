vim.loader.enable()

-- Set colorscheme right away
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("immediate_colorscheme", {clear = true}),
  callback = function ()
    vim.cmd.packadd("rose-pine")
    vim.cmd("colorscheme rose-pine")
  end
})


require("config")
require("plugins")
