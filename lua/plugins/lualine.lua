return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = function()
    -- 动态获取当前 Buffer 激活的 LSP 客户端名称（全栈利器）
    local function get_active_lsp()
      local msg = "No LSP"
      local buf_ft = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients { bufnr = buf_ft }
      if next(clients) == nil then return msg end
      local lsp_names = {}
      for _, client in ipairs(clients) do
        table.insert(lsp_names, client.name)
      end
      return "󰄭 " .. table.concat(lsp_names, ", ")
    end

    return {
      options = {
        theme = "auto",
        component_separators = { left = "│", right = "│" }, -- 换成更精致的细线分隔
        section_separators = { left = "", right = "" }, -- 保持你喜欢的无缝平滑过渡
        globalstatus = true, -- 保持全局状态栏
        disabled_filetypes = {
          statusline = { "neo-tree", "lazy", "mason", "alpha" }, -- 排除特定面板防止冲突
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str) return " " .. str end, -- 为模式加上精美 Vim 图标
          },
        },
        lualine_b = {
          { "branch", icon = "󰘬" }, -- 精致的 Git 分支图标
          "diff",
          {
            "diagnostics",
            -- 融合你之前特调的 Nerd Font 巨标，让报错更抓人眼球
            symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " },
          },
        },
        lualine_c = {
          { "filename", path = 1, file_status = true }, -- 显示相对路径，并带读写状态
        },
        lualine_x = {
          { get_active_lsp, color = { fg = "#ffddff", gui = "bold" } }, -- 实时监控 Rust/Vue 的 LSP 状态
          { "filetype", icon_only = false }, -- 显示带有精致图标的文件类型
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
