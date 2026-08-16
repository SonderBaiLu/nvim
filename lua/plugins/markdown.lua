-- =============================================================================
-- plugins/markdown.lua — Markdown 预览（默认不用 render-markdown，避免 TS 注入崩溃）
-- =============================================================================

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_page_title = "「${name}」Markdown 预览"
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "dark"
    end,
    keys = {
      { "<Leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "切换 Markdown 预览", ft = "markdown" },
    },
  },
  -- 可选就地渲染：需 treesitter main 稳定后，将 enabled 改为 true
  -- 在部分 Neovim 0.12 环境会因注入解析触发 range nil，故默认关闭
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    ft = { "markdown" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      render_modes = { "n", "c", "t" },
      latex = { enabled = false },
      html = { enabled = false },
      yaml = { enabled = false },
      heading = { enabled = true, sign = false },
      code = { enabled = true, sign = false, width = "block" },
      bullet = { enabled = true },
      checkbox = { enabled = true },
    },
  },
}
