-- lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- 延迟加载
  opts = {
    win = {
      border = "single", -- 适配 blink.cmp 补全框的 single 风格
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
			{ "<leader>b", group = "标签/缓冲区 (Buffers)" },
      { "<leader>w", group = "分屏/视窗管理" },
      { "<leader>f", group = "模糊查找/重构" },
      { "<leader>x", group = "诊断/代办列表" },
      { "<leader>g", group = "Git 状态管理" },
      { "<leader>D", group = "数据库 (Dadbod-UI)" },
      { "<leader>p", group = "Neovim 包体管理" },
      { "<leader>l", group = "语言服务/系统层" },
    })
  end,
}
