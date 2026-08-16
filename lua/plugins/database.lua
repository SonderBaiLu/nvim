-- =============================================================================
-- plugins/database.lua — PostgreSQL：vim-dadbod + UI + 补全
-- 快捷键前缀 <Leader>k（库），刻意避开 <Leader>d（调试），防止 which-key 大小写混淆
-- =============================================================================

return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<Leader>ku", "<cmd>DBUIToggle<cr>", desc = "切换数据库面板" },
      { "<Leader>kc", "<cmd>DBUIAddConnection<cr>", desc = "添加数据库连接" },
      { "<Leader>kf", "<cmd>DBUIFindBuffer<cr>", desc = "定位 SQL 缓冲" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 36
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
      -- 示例连接（请按需修改；勿把真实密码提交到公开仓库）
      vim.g.dbs = {
        { name = "本地 PostgreSQL 示例", url = "postgresql://postgres:postgres@127.0.0.1:5432/postgres" },
      }
      vim.g.db_ui_icons = {
        expanded = {
          db = "▾ 数据库",
          buffers = "▾ 缓冲",
          saved_queries = "▾ 查询",
          schemas = "▾ 模式",
          schema = "▾ 模式",
          tables = "▾ 表",
          table = "▾ 表",
        },
        collapsed = {
          db = "▸ 数据库",
          buffers = "▸ 缓冲",
          saved_queries = "▸ 查询",
          schemas = "▸ 模式",
          schema = "▸ 模式",
          tables = "▸ 表",
          table = "▸ 表",
        },
        saved_query = "*",
        new_query = "+",
        tables = "表",
        buffers = "缓冲",
      }
    end,
  },
}
