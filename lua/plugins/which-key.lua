-- =============================================================================
-- plugins/which-key.lua — 空格 Leader 中文菜单（which-key v3）
--
-- 重要：不要用同一字母的大小写做两个分组！
-- which-key 会把 <Leader>d 与 <Leader>D 混成同一棵树（标题像数据库、内容却是调试）。
-- 当前字母表（互不冲突）：
--   a 未用 | b 缓冲 | c 代码 | d 调试 | e 资源管理器
--   f 查找 | g Git  | h Git块 | k 数据库(库) | m Markdown
--   o 任务 | p 插件 | q 退出 | s 会话 | t 终端
--   u 界面 | w 窗口 | x 诊断
-- =============================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 200,
    notify = false, -- 避免启动时因旧冲突键刷屏；需要时 :checkhealth which-key
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
    icons = {
      mappings = true,
      colors = true,
      group = "",
    },
    win = {
      border = "rounded",
      title = true,
      title_pos = "center",
      padding = { 1, 2 },
    },
    sort = { "order", "local", "group", "alphanum", "mod" },
    spec = {
      { "<Leader>", group = "主菜单" },

      -- 分组（order 控制空格菜单显示顺序）
      { "<Leader>b", group = "缓冲区", order = 10, icon = { icon = "󰓩 ", color = "blue" } },
      { "<Leader>c", group = "代码", order = 20, icon = { icon = " ", color = "green" } },
      { "<Leader>d", group = "调试", order = 30, icon = { icon = " ", color = "red" } },
      { "<Leader>f", group = "查找", order = 40, icon = { icon = " ", color = "cyan" } },
      { "<Leader>g", group = "Git", order = 50, icon = { icon = " ", color = "orange" } },
      { "<Leader>h", group = "Git 块", order = 55, icon = { icon = " ", color = "orange" } },
      { "<Leader>k", group = "数据库", order = 60, icon = { icon = " ", color = "yellow" } },
      { "<Leader>m", group = "Markdown", order = 70, icon = { icon = " ", color = "purple" } },
      { "<Leader>o", group = "任务", order = 80, icon = { icon = " ", color = "yellow" } },
      { "<Leader>p", group = "插件", order = 90, icon = { icon = "󰒲 ", color = "azure" } },
      { "<Leader>s", group = "会话", order = 100, icon = { icon = " ", color = "green" } },
      { "<Leader>t", group = "终端", order = 110, icon = { icon = " ", color = "cyan" } },
      { "<Leader>u", group = "界面", order = 120, icon = { icon = "󰙵 ", color = "purple" } },
      { "<Leader>w", group = "窗口", order = 130, icon = { icon = " ", color = "blue" } },
      { "<Leader>x", group = "诊断", order = 140, icon = { icon = "󱖫 ", color = "red" } },

      -- 顶层单键
      { "<Leader>e", desc = "资源管理器", order = 1, icon = "󰙅 " },
      { "<Leader>q", desc = "退出窗口", order = 200, icon = "󰅖 " },
      { "<Leader>Q", desc = "强制退出全部", order = 201, icon = "󰩈 " },
      { "<Leader>N", desc = "通知历史", order = 202, icon = "󰎟 " },
      { "<Leader>?", desc = "当前缓冲快捷键", order = 203, icon = "󰋖 " },

      -- 非 Leader
      { "g", group = "跳转", mode = { "n", "v" } },
      { "]", group = "下一个" },
      { "[", group = "上一个" },
      { "z", group = "折叠/拼写" },
    },
  },
  keys = {
    {
      "<Leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "当前缓冲快捷键",
    },
  },
}
