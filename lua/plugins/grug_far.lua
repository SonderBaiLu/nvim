return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar" },
  keys = {
    -- 快捷键制导：按下空格 + f + r，瞬间拉起满血的大范围代码重构物理替换缓冲区
    { "<Leader>fr", "<cmd>GrugFar<cr>", desc = "重构：可视化项目级结构化替换矩阵 (IDEA Ctrl+Shift+R)" },
  },
  opts = {
    debounceMs = 150, -- 极速键盘键入时的增量渲染防抖，大幅降低后台 CPU 抖动
    transient = true, -- 当关闭该面板时，物理卸载其占用的内容资源，释放显存
    wrap = true, -- 替换长字符串时自动在视窗内进行物理折行
  },
}
