return {
  "xiyaowong/transparent.nvim",
  enabled = false,
  opts = {
    -- 强制把这些容易黑屏的浮窗和侧边栏也加入透明列表
    extra_groups = {
      "NormalFloat",
      "NvimTreeNormal",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "SnacksPickerNormal", -- 针对你图中的 snacks.picker
      "SnacksPickerList",
    },
    -- 清空排除项，不再允许任何黑块存在
    exclude_groups = {},
  },
}
