return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "User AstroFile", -- 延迟至打开实际代码文件时挂载，确保首屏秒开
  opts = {
    enable = true,
    max_lines = 4, -- 顶层固定上下文的最大行数，防止极端嵌套时遮挡过多代码
    min_window_height = 15, -- 窗口过小时自动关闭，保护核心视网膜区域
    line_numbers = true, -- 保持左侧相对行号同步，方便你随时进行物理跳转
    multiline_threshold = 2, -- 超过 2 行的冗长函数签名自动压缩渲染
    trim_scope = "outer", -- 当超出边界时，优先丢弃外层作用域
  },
}
