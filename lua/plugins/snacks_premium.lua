-- lua/plugins/snacks_premium.lua
return {
  "folke/snacks.nvim",
  priority = 1000, -- 强行提升至最高优先级
  lazy = false,    -- 彻底关闭懒加载，开机直接接管全局 UI 
  opts = {
    -- 1. 原有的平滑滚动和动画配置
    scroll = {
      enabled = true,
      animate = {
        duration = 150,
        easing = "linear",
      },
    },
    animate = { enabled = true },
    bigfile = { enabled = true },

    -- 🔥【核心改动】：彻底激活 snacks 原生的高性能选择器与输入框
    -- 它们会自动、完美地以现代极客悬浮窗接管系统的所有自动导包（Code Actions）和重命名界面
    picker = {
      enabled = true,
    },
    input = {
      enabled = true,
    },

    -- 2. 原有的高颜值的 Neovim 启动面板
    dashboard = {
      enabled = true,
      preset = {
        header = [[
       ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
       ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
       ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
       ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
       ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
       ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
