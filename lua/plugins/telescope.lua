-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  opts = {
    defaults = {
      -- 保持全局统一的高颜值圆角边框
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
  },
}
