if true then return {} end -- 警告：移除此行才能使本文件配置生效！目前此行让文件返回空配置，所有设置都会被跳过。

-- AstroLSP 允许你自定义 AstroNvim 中 LSP（语言服务器协议）的配置引擎
-- 完整的配置文档可以通过 `:h astrolsp` 查看
-- 注意：强烈建议安装 Lua 语言服务器 (`:LspInstall lua_ls`)，这样在编辑配置文件时能获得自动补全和文档提示。

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- 功能特性开关
    features = {
      codelens = true, -- 启动时是否刷新代码引用/测试等可点击提示（CodeLens）
      inlay_hints = false, -- 启动时是否显示内嵌提示（如变量类型、参数名）
      semantic_tokens = true, -- 是否启用语义高亮（更精确的语法着色）
    },

    -- =====================
    -- 代码格式化设置
    -- =====================
    formatting = {
      -- 保存时自动格式化
      format_on_save = {
        enabled = true, -- 全局启用保存时格式化
        allow_filetypes = { -- 仅针对以下文件类型启用（留空表示全部启用，取消注释并添加文件类型即可限制）
          -- "go",
        },
        ignore_filetypes = { -- 禁止对以下文件类型进行保存时格式化
          -- "python",
        },
      },
      disabled = { -- 禁用特定语言服务器的格式化功能（例如你想用 StyLua 格式化 Lua 代码时，可禁用 lua_ls）
        -- "lua_ls",
      },
      timeout_ms = 1000, -- 格式化超时时间（毫秒）
      -- filter = function(client) -- 完全自定义的格式化判断函数，返回 true 表示允许格式化
      --   return true
      -- end
    },

    -- =====================
    -- 手动指定要启用的语言服务器（不通过 mason 安装的）
    -- =====================
    servers = {
      -- "pyright"    -- 例如启用 Python 的 Pyright，确保已手动安装
    },

    -- =====================
    -- 语言服务器配置（传递给 `vim.lsp.config`）
    -- 针对具体客户端的配置也可以放在 `lsp/` 目录下（参见 `:h lsp-config`）
    -- =====================
    config = {
      -- ["*"] = { capabilities = {} }, -- 修改所有服务器的默认客户端配置，例如调整能力
    },

    -- =====================
    -- 语言服务器附加（启动）时的自定义处理器
    -- =====================
    handlers = {
      -- 键为 "*" 的函数会修改默认处理器，参数为服务器名称
      -- ["*"] = function(server) vim.lsp.enable(server) end

      -- 键为具体的服务器名称，设置为 false 则禁止启动该服务器
      -- rust_analyzer = false,
    },

    -- =====================
    -- 当语言服务器附加到缓冲区时，自动创建的命令（autocmd）
    -- =====================
    autocmds = {
      -- 第一个键是自动命令组名称 (:h augroup)
      lsp_codelens_refresh = {
        -- 条件：决定是否创建/删除该自动命令组。
        -- 可以是表示客户端能力的字符串，或签名 `fun(client, bufnr): boolean` 的函数。
        -- 每次执行时条件都会对所有客户端进行判断，如果所有客户端都不满足，该缓冲区的自动命令将被删除。
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- 要创建的自动命令列表
        {
          -- 触发事件
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)", -- 描述信息
          callback = function(args)
            -- 在功能开关打开的情况下刷新代码引用行
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.enable(true, { bufnr = args.buf }) end
          end,
        },
      },
    },

    -- =====================
    -- 语言服务器附加时配置的键盘映射
    -- =====================
    mappings = {
      n = { -- 普通模式下的映射
        -- `cond` 键可以是表示服务器能力的字符串，或一个函数 `fun(client, bufnr): boolean`，满足条件时映射才生效
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "跳转到当前符号的声明",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "切换当前缓冲区的语义高亮",
          cond = function(client)
            return client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },

    -- =====================
    -- 自定义的 on_attach 回调函数（在默认 on_attach 之后执行）
    -- 参数：client (语言服务器客户端对象) 和 bufnr (缓冲区编号)
    -- =====================
    on_attach = function(client, bufnr)
      -- 例如：禁用所有客户端的语义高亮提供者
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
