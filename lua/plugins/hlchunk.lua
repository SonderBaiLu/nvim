return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      use_treesitter = true, -- 基于 AST 计算块级边界，不依赖纯空格空格计数
      style = {
        { fg = "#cba6f7" }, -- 激活状态的作用域引导线，使用你的 Catppuccin 主色调
      },
    },
    indent = {
      enable = true,
      use_treesitter = true,
      style = {
        { fg = "#313244" }, -- 静态未激活状态下的背景辅助线
      },
    },
  },
}
