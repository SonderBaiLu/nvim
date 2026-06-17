return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- 满血开启 IDEA 同款静默代码责问提示
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 渲染在当前物理行的绝对尾部
      delay = 400, -- 光标停顿 0.4 秒自动拉取元数据，防止干扰正常视线
      ignore_whitespace = false,
    },
    -- 格式化渲染模板：图标 + 提交作者 • 格式化时间 • 提交摘要
    current_line_blame_formatter = " <author> • <author_time:%Y-%m-%d> • <summary>",
  },
}
