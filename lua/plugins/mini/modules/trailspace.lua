local utils = require("utils")

return (function()
	utils.set_hl("MiniTrailspace", { bg = utils.colors.green })
  vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = "*",
    callback = function()
      require("mini.trailspace").trim()
    end,
  })
  return {}
end)()
