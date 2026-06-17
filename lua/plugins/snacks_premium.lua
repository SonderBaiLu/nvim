return {
  "folke/snacks.nvim",
  opts = {
    -- 1. 启动轻量级平滑滚动内核，带有微小的物理阻尼感
    scroll = {
      enabled = true,
      animate = {
        duration = 150, -- 150毫秒的极速动画衰减，既有丝滑感又绝不拖泥带水
        easing = "linear",
      },
    },
    -- 2. 启动弹窗及命令面板的动态淡入淡出动画特效
    animate = { enabled = true },
    -- 3. 启动超大文件防御盾牌（写几万行 log 自动关闭高亮防止卡顿）
    bigfile = { enabled = true },
  },
}
