return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason", -- 延迟加载：仅当执行 :Mason 命令时才加载插件
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } }, -- 快捷键 <leader>cm 打开 Mason 管理界面
    opts = {
      ui = {
        border = "rounded", -- Mason 窗口使用圆角边框
      },
    },
    config = function(_, opts) -- 插件加载时调用的配置函数
      require("mason").setup(opts) -- 使用上面的 opts 初始化 mason.nvim
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" }, -- 依赖 mason.nvim，确保 mason 先加载
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" }, -- 按需加载：这些命令触发时才加载插件
    event = { "BufReadPost", "BufNewFile" }, -- 打开文件时自动触发插件加载，从而自动安装缺失工具
    opts = {
      ensure_installed = {
        -- 核心后端
        "lua-language-server", -- Lua 语言服务器（补全、诊断等）
        "stylua", -- Lua 代码格式化工具
        -- 核心前端
        "vtsls", -- TypeScript/JavaScript 语言服务器（比 tsserver 更轻快）
        "vue-language-server", -- Vue 语言服务器（支持 .vue 单文件组件）
        "vtsls",
        "prettier", -- 前端代码格式化（支持多种语言）
        "html-lsp", -- HTML 语言服务器
        "css-lsp", -- CSS/Less/SCSS 语言服务器
        "emmet-ls", -- Emmet 语言服务器（快速展开 HTML/CSS 片段）
        "rust-analyzer", -- Rust 核心链
        "taplo", -- Cargo.toml 自动补全与格式化工具
      },
    },
    config = function(_, opts) -- 插件加载时调用
      require("mason-tool-installer").setup(opts) -- 传入 opts 初始化，自动安装列表中缺失的工具
    end,
  },
}
