-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "saghen/blink.cmp", -- 完美注入你已有的 blink.cmp 补全能力！
    },
    config = function()
      local blink = require("blink.cmp")
      local capabilities = blink.get_lsp_capabilities()

      -- 1. 【核心改变】：使用官方新 API 注入全局能力，让所有服务自动获得 blink 补全
      vim.lsp.config("*", { capabilities = capabilities })

      -- 2. 基础通用语言服务一键点火（新版使用原生 vim.lsp.enable 激活）
      local servers = { "html", "cssls", "emmet_ls", "lua_ls", "taplo" }
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end

      -- 3. 完美的 Vue 3 视图解耦配置 (Volar)
      vim.lsp.config("volar", {
        init_options = {
          vue = { hybridMode = true },
        },
      })
      vim.lsp.enable("volar")

      -- 4. TS/JS 后端逻辑接管 (Vtsls) 并挂载 Vue 编译插件
      vim.lsp.config("vtsls", {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fn.stdpath("data")
                    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                  languages = { "vue" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      })
      vim.lsp.enable("vtsls")

      -- 5. 满血版 Rust 生产环境配置 (Rust Analyzer)
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = { group = "module" },
              prefix = "self",
            },
            cargo = {
              buildScripts = { enable = true }, -- 自动触发 build.rs 编译，防宏报错
            },
            procMacro = { enable = true },     -- 完美展开并解析 Rust 衍生宏
            diagnostics = {
              disabled = { "unresolved-proc-macro" }, -- 严防没有就绪的宏产生虚假报错
            },
          },
        },
      })
      vim.lsp.enable("rust_analyzer")

      -- 6. 浮动窗口外观美化（给诊断提示框加上精美的圆角）
      vim.diagnostic.config({
        float = { border = "rounded" },
      })
    end,
  },
}
