-- =============================================================================
-- plugins/flash.lua — 快速跳转（中文描述）
-- =============================================================================

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = { multi_window = true },
    label = { uppercase = false, rainbow = { enabled = true, shade = 5 } },
    modes = {
      char = { jump_labels = true },
      search = { enabled = true },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "闪现跳转",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "语法树选择",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "远程操作",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "语法树搜索",
    },
    {
      "<C-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "切换 Flash 搜索",
    },
  },
}
