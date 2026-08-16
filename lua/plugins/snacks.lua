-- =============================================================================
-- plugins/snacks.lua — 仪表盘 / 通知增强 / 实用工具（中文欢迎语）
-- 关联：noice（消息路由）；避免与 nvim-notify 双重弹窗重叠
-- =============================================================================

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "compact",
    },
    dashboard = {
      enabled = true,
      width = 64,
      preset = {
        header = [[
███╗   ██╗██╗   ██╗██████╗ ██╗███╗   ███╗
████╗  ██║██║   ██║██╔══██╗██║████╗ ████║
██╔██╗ ██║██║   ██║██████╔╝██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██╔══██╗██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██████╔╝██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═════╝ ╚═╝╚═╝     ╚═╝
        全栈开发环境 · 纯原生 Lua]],
        keys = {
          { icon = " ", key = "f", desc = "查找文件", action = ":Telescope find_files" },
          { icon = " ", key = "n", desc = "新建文件", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "全文搜索", action = ":Telescope live_grep" },
          { icon = " ", key = "r", desc = "最近文件", action = ":Telescope oldfiles" },
          { icon = " ", key = "c", desc = "编辑配置", action = ":e $MYVIMRC" },
          { icon = " ", key = "s", desc = "恢复会话", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "插件管理 Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "退出 Neovim", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
  keys = {
    {
      "<Leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "隐藏通知",
    },
    {
      "<Leader>uN",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "通知历史",
    },
    {
      "<Leader>N",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "通知历史",
    },
  },
}
