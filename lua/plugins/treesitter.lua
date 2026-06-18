-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false, -- 🔥 强制改为 false，确保高亮挂钩在启动的第一秒就绪
  build = ":TSUpdate",
  config = function()
    -- 1. 调用主线标准的 setup
    require("nvim-treesitter").setup({})

    -- 2. 声明你的全栈开发语言语法解析器列表
    local langs = { "lua", "vim", "vimdoc", "typescript", "vue", "html", "css", "rust", "toml", "ron" }

    -- 3. 强制触发全量增量安装
    require("nvim-treesitter").install(langs)
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype

        -- 将 Neovim 的文件类型安全映射为 Treesitter 内部可识别的语言名
        local lang = vim.treesitter.language.get_lang(ft) or ft

        -- 尝试点火高亮
        local ok = pcall(vim.treesitter.start, bufnr, lang)
        if ok then
          -- 如果高亮成功挂载，顺手启用 Treesitter 的代码缩进优化
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
