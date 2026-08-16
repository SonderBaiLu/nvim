-- =============================================================================
-- plugins/bufferline.lua — 现代标签栏（替代 barbar，对齐 Catppuccin）
-- =============================================================================

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "固定/取消固定标签" },
    { "<Leader>bU", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "关闭未固定标签" },
    { "<Leader>bO", "<cmd>BufferLineCloseOthers<cr>", desc = "关闭其他标签" },
    { "<Leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "关闭右侧标签" },
    { "<Leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "关闭左侧标签" },
  },
  opts = {
    options = {
      mode = "buffers",
      numbers = "none",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = (level:match("error") and "错误") or (level:match("warning") and "警告") or "提示"
        return " " .. icon .. ":" .. count
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "资源管理器",
          text_align = "left",
          highlight = "Directory",
          separator = true,
        },
      },
      show_buffer_close_icons = true,
      show_close_icon = false,
      separator_style = "thin",
      always_show_bufferline = true,
      hover = { enabled = true, delay = 150, reveal = { "close" } },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- 透明主题下微调标签底色
    vim.api.nvim_create_autocmd({ "ColorScheme", "BufAdd" }, {
      callback = function()
        pcall(vim.cmd, [[hi BufferLineFill guibg=NONE]])
      end,
    })
  end,
}
