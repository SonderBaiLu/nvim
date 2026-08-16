-- =============================================================================
-- plugins/mason.lua — Mason 自动安装 LSP / 格式化 / Lint / DAP 工具
-- 关联：lsp.lua、formatting.lua、lint.lua、dap.lua
-- =============================================================================

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    keys = { { "<Leader>pm", "<cmd>Mason<cr>", desc = "Mason 工具管理" } },
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- 实际服务器配置在 lsp.lua；此处仅确保安装
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "vtsls",
        "volar", -- mason-lspconfig 名称；对应包 vue-language-server（不是 vue_ls）
        "html",
        "cssls",
        "marksman",
        -- 不自动装 sqls/sqlls：sqls 需 Go；sqlls 在 Windows 需编译 sqlite3 原生模块
        -- SQL 补全由 vim-dadbod-completion（blink）提供，见 database.lua
        "taplo",
        "emmet_language_server",
      },
      automatic_enable = false, -- 由 lsp.lua 统一 enable，避免重复
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- 格式化
        "stylua",
        "prettier",
        "sql-formatter",
        -- Lint
        "eslint_d",
        -- DAP
        "codelldb",
        "js-debug-adapter",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
