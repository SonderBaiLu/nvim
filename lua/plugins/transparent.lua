return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").setup {
      extra_groups = {
        -- 基础区域
        "NormalFloat",
        "FloatBorder",
        "StatusLine",
        "StatusLineNC",

        -- 文件树区域 (Neo-tree)
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeWinSeparator",
        "NeoTreeHeader", -- 文件树顶部文字区域
        "NeoTreeHeaderBar", -- 文件树顶部条
        "NeoTreeTabActive", -- 文件树激活的标签
        "NeoTreeTabInactive", -- 文件树未激活的标签
        "NeoTreeRootName", -- 根目录名称

        -- 顶部标签栏 (Bufferline / Tabline)
        "BufferLineFill", -- 顶部整条栏的背景
        "BufferLineBackground", -- 未激活标签的背景
        "BufferLineSeparator", -- 分隔符
        "TabLine", -- 基础标签栏
        "TabLineFill", -- 标签栏填充
        "TabLineSel", -- 选中标签

        -- 顶部面包屑 (WinBar)
        "WinBar", -- 代码顶部的路径导航栏
        "WinBarNC", -- 未激活窗口的路径导航栏

        -- 全局搜索 (Telescope)
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopeResultsNormal",
      },
      exclude_groups = {},
    }
  end,
}
