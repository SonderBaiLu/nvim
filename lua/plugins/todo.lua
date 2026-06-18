-- lua/plugins/todo-comments.lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- 延迟加载：在打开文件时再加载，不拖慢启动速度
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = true, -- 在左侧行号旁边显示一个漂亮的图标
    sign_priority = 8,
    keywords = {
      -- 定义各种标签的图标和颜色
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" }, -- 你图片里的 TODO 会变成蓝色底色带小对勾
      HACK = { icon = " ", color = "warning" }, -- 临时脏实现
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    gui_style = {
      fg = "NONE", -- 字体颜色不变
      bg = "BOLD", -- 背景加粗高亮
    },
    highlight = {
      multiline = false, -- 是否高亮多行注释
      keyword = "wide", -- "fg" (前景色), "bg" (背景色), "wide" (类似标签的宽背景), "empty" (隐藏)
      after = "fg", -- 关键字后面的注释文本颜色跟随前景色
      comments_only = false, -- 只在注释里生效，防止在字符串里误杀
    },
    -- 适配你当前 Catppuccin 主题的颜色矩阵
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#F38BA8" }, -- 红色
      warning = { "DiagnosticWarn", "WarningMsg", "#F9E2AF" }, -- 黄色
      info = { "DiagnosticInfo", "#89B4FA" }, -- 蓝色
      hint = { "DiagnosticHint", "#A6E3A1" }, -- 绿色
      default = { "Identifier", "#CBA6F7" }, -- 紫色
      test = { "Identifier", "#F5C2E7" }, -- 粉色
    },
  },
  keys = {
    -- 配合 Telescope (如果使用了 Snacks.picker 也可以映射到 Snacks)
    { "<Leader>fT", "<cmd>TodoTelescope<cr>", desc = "查找：全局项目 TODO 列表" },
    -- 如果你想用 Trouble 面板在底部列出所有坑
    { "<Leader>xT", "<cmd>TodoTrouble<cr>", desc = "面板：项目待办事项" },
  },
}
