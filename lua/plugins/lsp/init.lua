-- 负责 nvim-lspconfig 初始化、LspAttach 键位与能力注入
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- 若你使用的是 blink.cmp，需引入其 capabilities 支持
      "saghen/blink.cmp",
    },
    config = function()
      -- 1. 注册 LspAttach 事件：集中管理快捷键
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- 常用 LSP 核心键位提示（按需添加/修改）
          map("gd", vim.lsp.buf.definition, "跳转到定义 (Goto Definition)")
          map("K", vim.lsp.buf.hover, "查看悬浮文档 (Hover Documentation)")
          map("<leader>rn", vim.lsp.buf.rename, "重命名符号 (Rename Symbol)")
          map("<leader>ca", vim.lsp.buf.code_action, "代码操作 (Code Action)")
        end,
      })

      -- 2. 获取补全引擎的 capabilities (能力协商)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- 3. 基础服务初始化示例（后续可解耦至 servers 模块）
      local lspconfig = require "lspconfig"

      -- TypeScript 服务端配置（确认使用 ts_ls）
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }
      local servers = require "lsp.servers"
      local lspconfig = require "lspconfig"

      for server_name, server_opts in pairs(servers) do
        server_opts.capabilities = capabilities
        lspconfig[server_name].setup(server_opts)
      end
    end,
  },
}
