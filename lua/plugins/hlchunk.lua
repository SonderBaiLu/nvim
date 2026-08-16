-- =============================================================================
-- plugins/hlchunk.lua — 缩进阶梯与作用域高亮
-- =============================================================================

return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      use_treesitter = true,
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        right_arrow = ">",
      },
      style = {
        { fg = "#cba6f7" },
        { fg = "#f38ba8" },
      },
      duration = 150,
      delay = 80,
    },
    indent = {
      enable = true,
      chars = { "│" },
      style = {
        vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
      },
    },
    line_num = { enable = false },
    blank = { enable = false },
  },
}
