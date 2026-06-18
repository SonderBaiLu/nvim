-- lua/lazy_init.lua
-- =============================================================================
--              1. 纯原生 lazy.nvim 插件管理器自动安装与引导
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
--              2. 纯净初始化插件树 (扫描并挂载你的独立插件目录)
-- =============================================================================
require("lazy").setup({
  spec = {
    -- 自动导入 lua/plugins/ 目录下的所有独立插件文件 (如 lualine, lsp, treesitter 等)
    { import = "plugins" },
  },
  install = {
    colorscheme = { "catppuccin" }, -- 过渡期兜底主题
  },
  ui = {
    border = "rounded", -- 让 lazy 界面使用漂亮的圆角边框
  },
  performance = {
    rtp = {
      -- 禁用 Vim 内置的一些过时非必要垃圾插件，让编辑器快如闪电
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- =============================================================================
--              3. 终极点火：在所有独立插件就绪后，正式激活全局主题
-- =============================================================================
vim.cmd.colorscheme("catppuccin")
