return {
  -- 1. 解决标签同步重命名 (改前面的 <div>，后面的 </div> 自动跟着变)
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter" },
    opts = {
      opts = {
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
    },
  },

  -- 2. 引入官方社区的前端语言包增强配置
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.vue" },

  -- 3. 核心大招：强制开启 Vue 的混合模式 (Hybrid Mode)
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        -- 让 Volar 卸下重担，只处理 Vue 模板，把代码逻辑的推导交出去
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
        -- 强化 vtsls，让它具备解析 .vue 文件的能力，彻底解决自动导入和 . 属性推导问题
        vtsls = {
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    -- 动态获取 Mason 安装的 Vue 插件路径
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
  },
}
