-- =============================================================================
-- plugins/devicons.lua — 文件图标（被 lualine / neo-tree / bufferline / telescope 依赖）
-- =============================================================================

return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    color_icons = true,
    default = true,
  },
}
