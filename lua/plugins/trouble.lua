-- =============================================================================
-- plugins/trouble.lua — 诊断列表（中文）
-- =============================================================================

return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    auto_close = true,
    focus = true,
    modes = {
      diagnostics = {
        desc = "诊断列表",
      },
      symbols = {
        desc = "文档符号",
      },
      lsp = {
        desc = "LSP 定义/引用",
      },
    },
  },
  keys = {
    { "<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "诊断列表面板" },
    { "<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "当前缓冲诊断" },
    { "<Leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "符号面板" },
    { "<Leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP 引用定义" },
    { "<Leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "位置列表" },
    { "<Leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "快速修复列表" },
  },
}
