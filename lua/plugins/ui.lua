-- =============================================================================
-- plugins/ui.lua — Noice 命令/消息 UI（与 snacks.notifier 协同，不叠 nvim-notify）
-- =============================================================================

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- 使用 snacks.notifier，避免再挂 nvim-notify 造成双重弹窗
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true },
        signature = { enabled = true, auto_open = { enabled = true } },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim", title = "命令" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", title = "向下搜索" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", title = "向上搜索" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash", title = "过滤" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua", title = "Lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "", title = "帮助" },
        },
      },
      messages = {
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      views = {
        cmdline_popup = {
          position = { row = "35%", col = "50%" },
          size = { width = 60, height = "auto" },
          border = { style = "rounded", padding = { 0, 1 } },
        },
      },
      routes = {
        { filter = { event = "msg_show", find = "已写入" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "written" }, opts = { skip = true } },
      },
    },
  },
}
