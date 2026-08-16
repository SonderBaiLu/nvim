-- =============================================================================
-- plugins/comment.lua — 智能注释（gc / gcc）
-- =============================================================================

return {
  "numToStr/Comment.nvim",
  keys = {
    { "gc", mode = { "n", "v" }, desc = "行注释" },
    { "gb", mode = { "n", "v" }, desc = "块注释" },
  },
  opts = {
    mappings = {
      basic = true,
      extra = true,
    },
  },
}
