-- =============================================================================
-- plugins/lualine.lua — 中文状态栏（Catppuccin Mocha）
-- 关联：gitsigns / LSP / S.lsp_client_names
-- =============================================================================

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local mode_map = {
      n = "普通",
      i = "插入",
      v = "可视",
      V = "视行",
      ["\22"] = "视块",
      c = "命令",
      s = "选择",
      S = "选行",
      ["\19"] = "选块",
      R = "替换",
      r = "替换",
      ["!"] = "外部",
      t = "终端",
    }

    return {
      options = {
        theme = "catppuccin",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
      },
      sections = {
        lualine_a = {
          {
            function()
              return mode_map[vim.fn.mode()] or vim.fn.mode()
            end,
            icon = "",
          },
        },
        lualine_b = {
          { "branch", icon = "", fmt = function(s)
            return s ~= "" and ("分支 " .. s) or ""
          end },
          {
            "diff",
            symbols = { added = "新增+", modified = "修改~", removed = "删除-" },
          },
        },
        lualine_c = {
          { "filename", path = 1, symbols = { modified = " [已改]", readonly = " [只读]", unnamed = "[未命名]" } },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "错误:", warn = "警告:", info = "信息:", hint = "提示:" },
          },
          {
            function()
              local names = require("S").lsp_client_names(0)
              if #names == 0 then
                return "LSP:无"
              end
              return "LSP:" .. table.concat(names, ",")
            end,
          },
          { "filetype", icon_only = false },
        },
        lualine_y = { { "progress", fmt = function(s)
          return "进度 " .. s
        end } },
        lualine_z = { { "location", fmt = function(s)
          return "位置 " .. s
        end } },
      },
      extensions = { "neo-tree", "lazy", "toggleterm", "trouble", "mason", "nvim-dap-ui" },
    }
  end,
}
