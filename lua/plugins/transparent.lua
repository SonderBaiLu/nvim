return {
  "xiyaowong/transparent.nvim",
  -- 职责：解开锁，让透明底座全面生效
  enabled = true,
  opts = {
    -- 物理防御：强行把容易变黑块的组件全部变成通透玻璃质感
    extra_groups = {
      "NormalFloat", -- LSP 悬浮提示框
      "FloatBorder", -- 弹窗边框
      "NvimTreeNormal", -- 文件树背景
      "NeoTreeNormal", -- NeoTree 侧边栏
      "NeoTreeNormalNC",
      "BlinkCmpMenu", -- Blink 自动补全菜单主背景
      "BlinkCmpMenuBorder", -- Blink 补全菜单边框
      "BlinkCmpDoc", -- AI 及代码文档右侧浮窗
      "BlinkCmpDocBorder",
    },
    exclude_groups = {}, -- 不允许任何黑块例外
  },
}
