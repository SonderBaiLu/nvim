---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- 核心后端
        "lua-language-server",
        "stylua",

        -- 核心前端（完美支撑你 Vue/Tailwind 物理换行的底层需要）
        "vtsls",
        "vue-language-server",
        "prettier",
        "html-lsp",
        "css-lsp",
        "emmet-ls",
      },
    },
  },
}
