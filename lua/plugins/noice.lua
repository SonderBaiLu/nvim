return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false },

      -- 覆盖 markdown 渲染，使其支持 LSP 的悬浮文档美化
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- 核心美化：把命令栏移到屏幕中间，带毛玻璃效果
    presets = {
      bottom_search = false, -- 禁用底部的搜索栏
      command_palette = true, -- 启用居中的命令面板
      long_message_to_split = true, -- 长消息发送到分割窗口
      inc_rename = false, -- 增量重命名
      lsp_doc_border = true, -- 悬浮文档带边框
    },
  },
}
