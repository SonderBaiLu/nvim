return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    borders = true,
    -- 🏷️ 顶部源选择器：美化保留
    source_selector = {
      winbar = true,
      statusline = false, -- 只需一个入口，避免冗余
      content_layout = "center",
      separator = "",
      show_separator_on_edge = true,
      sources = {
        { source = "filesystem", display_name = "File" },
        { source = "buffers", display_name = "Buffers" },
        { source = "git_status", display_name = "Git" },
      },
    },

    -- 📁 文件系统行为
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true, -- 右侧文件切换时左侧自动跟踪
      },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true, -- 隐藏文件以灰色显示，不彻底消失
        hide_dotfiles = false, -- 显示 .env, .gitignore 等
        hide_gitignored = true, -- 隐藏被 git 忽略的文件夹，避免卡顿
      },
    },

    -- 🖥️ 窗口 & 映射
    window = {
      width = 30,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<space>"] = "none", -- 防止污染 leader 键
        ["<C-v>"] = "open_vsplit",
        ["<C-x>"] = "open_split",
      },
    },

    -- 视觉样式
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        highlight = "NeoTreeIndentMarker",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "󰈚",
      },
      git_status = {
        symbols = {
          added = "✚",
          modified = "",
          deleted = "✖",
          untracked = "",
          ignored = "",
          conflict = "",
        },
      },
    },
  },
}
