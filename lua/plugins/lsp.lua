return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local S = require "S"

    -- 中文诊断级别与符号
    local severity_zh = {
      [vim.diagnostic.severity.ERROR] = "错误",
      [vim.diagnostic.severity.WARN] = "警告",
      [vim.diagnostic.severity.INFO] = "信息",
      [vim.diagnostic.severity.HINT] = "提示",
    }

    vim.diagnostic.config {
      virtual_text = {
        spacing = 2,
        prefix = "●",
        format = function(diagnostic)
          local level = severity_zh[diagnostic.severity] or "诊断"
          return string.format("%s: %s", level, diagnostic.message)
        end,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "错",
          [vim.diagnostic.severity.WARN] = "警",
          [vim.diagnostic.severity.INFO] = "信",
          [vim.diagnostic.severity.HINT] = "示",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "if_many",
        header = "诊断详情",
        prefix = function(diagnostic) return severity_zh[diagnostic.severity] .. ": ", "Comment" end,
      },
    }

    -- Vue 官方 TS 插件路径（关联 vtsls）
    local vue_plugin_path =
      S.data_path("mason", "packages", "vue-language-server", "node_modules", "@vue", "typescript-plugin")
    local vue_plugin = {
      name = "@vue/typescript-plugin",
      location = vue_plugin_path,
      languages = { "vue" },
      configNamespace = "typescript",
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    ---@type table<string, vim.lsp.Config>
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim", "Snacks" } },
            hint = { enable = true },
          },
        },
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" }, -- 关联 nvim-lint / Clippy
            diagnostics = { enable = true },
            inlayHints = { lifetimeElisionHints = { enable = "always" } },
          },
        },
      },
      vtsls = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = { vue_plugin },
            },
          },
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
            },
          },
        },
      },
      -- 当前 nvim-lspconfig 仍使用 volar 作为服务器名（映射到 vue-language-server）
      volar = {
        filetypes = { "vue" },
      },
      html = {},
      cssls = {},
      marksman = {},
      -- SQL：不启用 sqls/sqlls（Windows 安装易失败）；补全见 dadbod + blink
      taplo = {},
      emmet_language_server = {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
      },
    }

    for name, opts in pairs(servers) do
      opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
      -- Neovim 0.11+ 原生 API；0.10 回退到 nvim-lspconfig
      if vim.lsp.config then
        vim.lsp.config(name, opts)
        vim.lsp.enable(name)
      else
        require("lspconfig")[name].setup(opts)
      end
    end

    -- LSP 附加后的缓冲级映射补充
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("SLspAttach", { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        local has_hint = false
        if vim.fn.has "nvim-0.11" == 1 then
          has_hint = client:supports_method "textDocument/inlayHint"
        else
          has_hint = client.supports_method "textDocument/inlayHint"
        end
        if has_hint and vim.lsp.inlay_hint then pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf }) end
      end,
    })
  end,
}
