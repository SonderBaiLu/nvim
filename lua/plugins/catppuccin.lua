return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    -- 1. 基础环境：主编辑区背景透明，融入系统壁纸
    transparent_background = true,

    -- 2. 空间层级划分 (核心美化点)
    styles = {
      sidebars = "transparent", -- 左侧文件树 (NeoTree) 保持透明，作为画框
      floats = "dark", -- 【关键防御】所有浮动窗口(补全/提示)强制使用深色实体背景！绝不和壁纸打架
    },

    -- 3. 深度集成你安装的其他现代插件，应用专属化 UI
    integrations = {
      cmp = true,
      blink_cmp = true,
      noice = true,
      dropbar = {
        enabled = true,
        color_mode = "macchiato",
      },
      snacks = true,
      telescope = {
        enabled = true,
        style = "nvchad", -- 给 Telescope 搜索框应用一种非常现代的、带阴影的实体面板样式
      },
      -- 开启文件树的高级色彩支持
      neotree = true,
    },
  },
}
