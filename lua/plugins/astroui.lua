return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheL：me
    colorscheme = "catppuccin",
    transparent_background = true,
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
      },
      global = {
        -- 核心浮窗边框：设置为亮蓝色(或你主题的主色调)，背景保持透明(NONE)
        FloatBorder = { fg = "#89b4fa", bg = "NONE" },

        -- 针对你图中使用的 snacks.picker 弹出框进行边界强化
        SnacksPickerBorder = { fg = "#cba6f7", bg = "NONE" },
        SnacksPickerBox = { fg = "#cba6f7", bg = "NONE" },

        -- 针对 cmp/blink 补全菜单的边框
        BlinkCmpMenuBorder = { fg = "#cba6f7", bg = "NONE" },
        BlinkCmpDocBorder = { fg = "#cba6f7", bg = "NONE" },

        -- 可选：让 Telescope 边框也保持一致
        TelescopeBorder = { fg = "#cba6f7", bg = "NONE" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
