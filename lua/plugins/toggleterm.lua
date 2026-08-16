-- =============================================================================
-- plugins/toggleterm.lua — 浮动终端（<C-\>）
-- =============================================================================

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { [[<C-\>]], "<cmd>ToggleTerm direction=float<cr>", desc = "浮动终端", mode = { "n", "t" } },
    { "<Leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "浮动终端" },
    { "<Leader>th", "<cmd>ToggleTerm size=12 direction=horizontal<cr>", desc = "底部终端" },
    { "<Leader>tv", "<cmd>ToggleTerm size=50 direction=vertical<cr>", desc = "侧边终端" },
  },
  opts = function()
    local S = require("S")
    local shell = vim.o.shell
    if S.is_windows then
      -- 优先 PowerShell 7，其次 Windows PowerShell
      if vim.fn.executable("pwsh") == 1 then
        shell = "pwsh"
      elseif vim.fn.executable("powershell") == 1 then
        shell = "powershell"
      end
    end
    return {
      size = function(term)
        if term.direction == "horizontal" then
          return 12
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
        return 20
      end,
      open_mapping = nil, -- 由 keys 显式绑定，避免冲突
      shell = shell,
      shade_terminals = true,
      shading_factor = -10,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
    }
  end,
}
