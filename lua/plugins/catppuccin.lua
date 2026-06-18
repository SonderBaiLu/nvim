return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = {
    flavour = "mocha",
    transparent_background = true, -- 主背景透明
    term_colors = true,
    integrations = {
      blink_cmp = true,
      gitsigns = true,
      neotree = true,
      noice = true,
      notify = true,
      treesitter = true,
      treesitter_context = true,
      mason = true,
      flash = true,
      lualine = true,
    },
    -- 把其他 UI 的背景也干掉
    custom_highlights = function(colors)
      return {
        -- 浮动窗口
        NormalFloat = { bg = colors.none },
        FloatBorder = { bg = colors.none, fg = colors.overlay0 },
        FloatTitle = { bg = colors.none },

        -- 状态栏、标签栏
        StatusLine = { bg = colors.none },
        StatusLineNC = { bg = colors.none },
        TabLine = { bg = colors.none },
        TabLineFill = { bg = colors.none },
        TabLineSel = { bg = colors.none },

        -- 窗口分割线
        WinSeparator = { bg = colors.none, fg = colors.surface0 },
        VertSplit = { bg = colors.none, fg = colors.surface0 },

        -- 行号、符号栏
        LineNr = { bg = colors.none },
        SignColumn = { bg = colors.none },
        FoldColumn = { bg = colors.none },
        CursorLine = { bg = colors.surface0 }, -- 当前行轻微高亮，想完全透明就改成 colors.none
        CursorColumn = { bg = colors.none },

        -- 补全菜单 / 弹出菜单
        Pmenu = { bg = colors.none },
        PmenuSel = { bg = colors.surface0, fg = colors.text },
        PmenuSbar = { bg = colors.none },
        PmenuThumb = { bg = colors.overlay0 },
      }
    end,
  },
}
