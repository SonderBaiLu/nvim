-- 负责语言服务器、DAP、Linter 的自动下载与管理
return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- 注意：TypeScript 语言服务名称为 "ts_ls"（而非已被废弃的 tsserver）
      ensure_installed = {
        "ts_ls",
        "lua_ls",
        "html",
        "cssls",
      },
      automatic_installation = true,
    },
  },
}
