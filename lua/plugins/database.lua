return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- 启用 Nerd Fonts 图标支持，让数据库树状图更好看
    vim.g.db_ui_use_nerd_fonts = 1

    -- 确保默认的展开折叠行为符合直觉
    vim.g.db_ui_show_help = 0
  end,
}
