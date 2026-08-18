-- 维护各语言服务器的具体配置表（含 TypeScript 配置）
-- lua/lsp/servers.lua
-- 职责：仅维护各语言服务器的具体配置选项，不参与 Lazy 插件声明
return {
  ts_ls = {
    -- 可在此放置 TypeScript 特定的 settings 或 init_options
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}
