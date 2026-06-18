return {
  "neovim/nvim-lspconfig",
  lazy = false, -- 开机即满血，抢占首发点火权
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    local lsp = vim.lsp

    -- 1. 动态获取 Vue 语言服务器的绝对路径（严格遵循官方 Wiki 标准）
    local vue_language_server_path = vim.fn.stdpath "data"
      .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

    -- 2. 构造官方要求的 Vue TS 插件对象
    local vue_plugin = {
      name = "@vue/typescript-plugin",
      location = vue_language_server_path,
      languages = { "vue" },
      configNamespace = "typescript",
    }

    -- 3. 声明全栈核心语言服务器矩阵
    local servers = {
      rust_analyzer = {},
      taplo = {},
      lua_ls = {
        root_markers = { ".git", "init.lua" },
        settings = {
          Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } },
        },
      },
      vtsls = {
        -- 【核心破局点 1：强行让 vtsls 允许挂载到 Vue 文件上】
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        settings = {
          -- 【核心破局点 2：标准的官方插件注入 API】
          vtsls = {
            tsserver = {
              globalPlugins = { vue_plugin },
            },
          },
        },
      },
      vue_ls = {
        -- 最新版 nvim-lspconfig 内部已内置请求转发机制，只需绑定文件类型即可
        filetypes = { "vue" },
      },
    }

    -- 4. 开机点火：全盘启动与补全引擎接管
    for server_name, server_opts in pairs(servers) do
      local success, blink = pcall(require, "blink.cmp")
      if success then server_opts.capabilities = blink.get_lsp_capabilities(server_opts.capabilities) end

      -- Neovim 0.11+ 标准 API
      if lsp.config then
        lsp.config(server_name, server_opts)
        lsp.enable(server_name)
      end
    end

    -- 5. 视觉增强：依然保留你的顶级高亮诊断 UI
    vim.diagnostic.config {
      virtual_text = { spacing = 4, prefix = "●" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
      update_in_insert = false,
      severity_sort = true,
      float = {
        focused = false,
        border = "rounded",
        source = "always",
      },
    }

    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "*",
      callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end,
    })
  end,
}
