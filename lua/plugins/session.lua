-- =============================================================================
-- plugins/session.lua — 会话自动保存与恢复（persisted.nvim）
-- 关联：snacks dashboard 的 session 分区
-- =============================================================================

return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
  lazy = false,
  opts = {
    autostart = true,
    autoload = false, -- 仪表盘手动恢复，避免干扰启动路径
    use_git_branch = true,
    should_save = function()
      return vim.fn.argc() == 0
    end,
  },
  keys = {
    { "<Leader>ss", "<cmd>SessionSave<cr>", desc = "保存会话" },
    { "<Leader>sl", "<cmd>SessionLoad<cr>", desc = "加载会话" },
    { "<Leader>sd", "<cmd>SessionDelete<cr>", desc = "删除会话" },
    { "<Leader>st", "<cmd>SessionToggle<cr>", desc = "切换会话自动保存" },
  },
}
