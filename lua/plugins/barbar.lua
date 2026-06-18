-- lua/plugins/barbar.lua
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- 让标签页上能显示 Git 修改状态
    "nvim-tree/nvim-web-devicons", -- 图标支持
  },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    animation = true, -- 开启平滑切换动画
    clickable = true, -- 鼠标点击可以直接切标签
    icons = {
      buffer_index = false,
      filetype = { enabled = true },
      button = "", -- 漂亮的关闭小叉号
    },
  },
}
