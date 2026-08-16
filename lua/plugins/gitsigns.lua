-- =============================================================================
-- plugins/gitsigns.lua — 行内 Git 状态与 blame
-- =============================================================================

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    current_line_blame = true,
    current_line_blame_opts = { delay = 400, virt_text_pos = "eol" },
    current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> · <summary>",
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map("n", "]h", function()
        gs.nav_hunk("next")
      end, "下一个 Git 块")
      map("n", "[h", function()
        gs.nav_hunk("prev")
      end, "上一个 Git 块")
      map("n", "<Leader>hs", gs.stage_hunk, "暂存 Git 块")
      map("n", "<Leader>hr", gs.reset_hunk, "重置 Git 块")
      map("n", "<Leader>hp", gs.preview_hunk, "预览 Git 块")
      map("n", "<Leader>hb", function()
        gs.blame_line({ full = true })
      end, "行 Blame 详情")
      map("n", "<Leader>hd", gs.diffthis, "与索引对比")
    end,
  },
}
