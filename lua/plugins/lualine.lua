-- lua/plugins/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" }, -- 无缝平滑过渡
        globalstatus = true, -- 全局状态栏
        disabled_filetypes = {
          statusline = { "neo-tree", "lazy", "mason" }, -- 排除特定面板防止冲突
        },
      },
      sections = {
        lualine_a = { { "mode", right_padding = 2 } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- 显示相对路径
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
