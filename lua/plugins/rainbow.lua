-- =============================================================================
-- plugins/rainbow.lua — 括号彩虹着色（Treesitter 生态现代替代）
-- 关联：nvim-treesitter / Catppuccin rainbow_delimiters 集成
-- =============================================================================

return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  submodules = false, -- 跳过测试/LuaLS 子模块，加快安装
  config = function()
    local ok, rainbow = pcall(require, "rainbow-delimiters")
    if not ok then
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
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }
  end,
}
