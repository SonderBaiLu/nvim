-- =============================================================================
-- plugins/formatting.lua — conform.nvim 保存时自动格式化
-- 关联：mason-tool-installer（stylua / prettier / sql-formatter）；Rust 用 rustfmt
-- =============================================================================

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<Leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "格式化代码",
    },
  },
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      sql = { "sql_formatter" },
      toml = { "taplo" },
    },
    format_on_save = function(bufnr)
      -- 大文件跳过同步格式化，避免卡顿
      local max = 512 * 1024
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max then
        return nil
      end
      return { timeout_ms = 1500, lsp_fallback = true }
    end,
    formatters = {
      sql_formatter = {
        prepend_args = { "--language", "postgresql" },
      },
      prettier = {
        prepend_args = { "--print-width", "100" },
      },
    },
  },
}
