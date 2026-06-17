return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = { enabled = false }, -- 保持原生全局搜索的纯净度，不盲目污染 / 键
    },
  },
  keys = {
    -- 核心点火：按下 s 键瞬间对全屏进行二维字符拓扑标记，敲击高亮标签即可完成闪现
    {
      "s",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "运动：全屏高维视觉制导瞬时跳跃",
    },
    -- 按下 S 键，基于当前语法树的作用域边界进行智能视觉区块选择（比 IDEA 的 Ctrl+W 更具确定性）
    {
      "S",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter() end,
      desc = "运动：基于 AST 语义块的视觉选择",
    },
  },
}
