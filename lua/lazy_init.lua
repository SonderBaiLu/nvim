-- =============================================================================
-- lazy_init.lua — lazy.nvim 引导、懒加载策略与启动性能优化
-- 分析启动：:Lazy profile 或 <Leader>pp
-- =============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true, -- 默认懒加载，各插件用 event/cmd/ft/keys 显式声明
    version = false, -- 跟踪最新稳定提交；可用 version = "*" 锁 semver
  },
  install = {
    colorscheme = { "catppuccin", "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  ui = {
    border = "rounded",
    title = "插件管理",
    pills = true,
  },
  performance = {
    cache = { enabled = true },
    rtp = {
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
  profiling = {
    -- 启动后执行 :Lazy profile 查看各插件耗时
    loader = true,
    require = true,
  },
})
