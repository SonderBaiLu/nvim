-- =============================================================================
-- plugins/frontend.lua — 前端增强：标签自动闭合（HTML / JSX / Vue）
-- 关联：Treesitter；LSP 由 vtsls / vue_ls / html / cssls 提供
-- =============================================================================

return {
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      per_filetype = {
        ["html"] = { enable_close = true },
        ["vue"] = { enable_close = true },
      },
    },
  },
}
