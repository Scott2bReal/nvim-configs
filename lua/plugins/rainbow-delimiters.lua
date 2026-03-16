return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local has_rainbow, rainbow = pcall(require, "rainbow-delimiters")
    if not has_rainbow then
      vim.notify("Failed to load rainbow delimiters")
      return
    end
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow.strategy["global"],
        vim = rainbow.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
        tsx = "rainbow-parens",
      },
      highlight = {
        "RainbowDelimiterYellow",
        "RainbowDelimiterCyan",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterRed",
        "RainbowDelimiterBlue",
      },
    }
  end,
}
