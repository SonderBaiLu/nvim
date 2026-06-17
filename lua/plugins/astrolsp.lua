---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false, -- 关闭内嵌提示，防止 Rust 的冗长类型挤乱你的代码
      semantic_tokens = true,
    },
    -- 核心优化点 1：开启满血保存自动格式化
    formatting = {
      format_on_save = {
        enabled = true, -- 写完代码 :w 保存时，自动排版
      },
      timeout_ms = 2000, -- 给 rust-analyzer 和 prettier 充分的响应时间
    },
    -- 核心优化点 2：Vue 前后端解耦配置（完美继承你之前的要求）
    config = {
      volar = {
        init_options = {
          vue = { hybridMode = true },
        },
      },
      vtsls = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fn.stdpath "data"
                    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                  languages = { "vue" },
                  configNamespace = "typescript",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
