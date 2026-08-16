-- =============================================================================
-- plugins/neo-tree.lua — 文件树（跟随当前文件 / Git / 缓冲区）
-- =============================================================================

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    -- 以目录启动时自动打开文件树
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NeoTree_start", { clear = true }),
      once = true,
      callback = function()
        if package.loaded["neo-tree"] then
          return
        end
        local stats = (vim.uv or vim.loop).fs_stat(vim.fn.argv(0) or "")
        if stats and stats.type == "directory" then
          require("neo-tree")
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sources = { "filesystem", "buffers", "git_status" },
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = " 文件 " },
        { source = "buffers", display_name = " 缓冲 " },
        { source = "git_status", display_name = " Git " },
      },
    },
    default_component_configs = {
      indent = { padding = 0, with_expanders = true },
      icon = { folder_closed = "", folder_open = "", folder_empty = "" },
      modified = { symbol = "[已改]" },
      git_status = {
        symbols = {
          added = "新增",
          deleted = "删除",
          modified = "修改",
          renamed = "重命名",
          untracked = "未跟踪",
          ignored = "忽略",
          unstaged = "未暂存",
          staged = "已暂存",
          conflict = "冲突",
        },
      },
    },
    window = {
      position = "left",
      width = 32,
      mappings = {
        ["<space>"] = "none",
        ["l"] = "open",
        ["h"] = "close_node",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path)
            vim.notify("已复制路径: " .. path, vim.log.levels.INFO, { title = "资源管理器" })
          end,
          desc = "复制绝对路径",
        },
      },
    },
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = { enabled = true, leave_dirs_open = false },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = { "node_modules", ".git", "target", "dist" },
      },
    },
  },
}
