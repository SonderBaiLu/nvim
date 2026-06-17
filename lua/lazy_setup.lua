require("lazy").setup(
  {
    {
      "AstroNvim/AstroNvim", -- 插件仓库
      version = "^6", -- 锁定主版本 v6.*，不自动追 nightly
      import = "astronvim.plugins", -- 导入 AstroNvim 内置的插件定义
      opts = { -- 传给 AstroNvim 的配置选项（必须在 import 之前设置）
        mapleader = " ", -- 全局前缀键设为空格
        maplocalleader = ",", -- 局部前缀键设为逗号
        icons_enabled = true, -- 是否启用图标（需要 Nerd Font）
        pin_plugins = nil, -- 插件版本固定策略，nil 表示跟随 AstroNvim 默认
        update_notifications = true, -- 是否在需要二次更新固定插件时弹出提醒
      },
    },
    { import = "community" }, -- 导入 AstroNvim 社区插件包
    { import = "plugins" }, -- 导入用户自己写的插件目录（lua/plugins/）
  } --[[@as LazySpec]], -- 类型注解：告诉 Lua LSP 前面的表是 LazySpec 类型
  {
    -- 第二个大表：lazy.nvim 自身的配置（LazyConfig）
    install = {
      colorscheme = { "catppuccin" }, -- 安装时使用的主题，首选 catppuccin，备选 habamax
    },
    ui = {
      backdrop = 90, -- 窗口背景透明度（100 为完全不透明）
    },
    performance = {
      rtp = {
        disabled_plugins = { -- 禁用内置非必要插件，加速启动
          "gzip",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "zipPlugin",
        },
      },
    },
  } --[[@as LazyConfig]]
) -- 类型注解：告诉 Lua LSP 后面的表是 LazyConfig 类型
