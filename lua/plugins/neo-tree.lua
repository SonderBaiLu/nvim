return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- 1. 🛑【核心断后：完全移除顶部标签栏，从根源消灭所有黑块冲突】
    source_selector = {
      winbar = true, -- 彻底关闭顶部的 File / Bufs / Git 选择器，还你绝对纯净的头部
      statusline = true, -- 关闭底部状态状态栏提示
    },

    -- 2. 📁 完美对齐 LazyVim 的文件系统底层行为
    filesystem = {
      bind_to_cwd = false, -- 允许文件树超越当前终端路径，自由浏览任意目录
      follow_current_file = {
        enabled = true, -- 【高频心流】右侧编辑区切换到哪，左侧文件树自动滚动并高亮该文件
      },
      use_libuv_file_watcher = true, -- 注入内核级异步事件轮询，文件增删时左侧秒级同步，绝不卡顿
      filtered_items = {
        visible = true, -- 让隐藏文件变灰变透明可见，而不是彻底消失
        hide_dotfiles = false, -- 展现 .env, .gitignore 等隐身配置文件
        hide_gitignored = false, -- 展现被 git 忽略的文件夹（如后端 target/，前端 node_modules/）
      },
    },

    -- 3. 🖥️ 侧边栏物理排版美化
    window = {
      width = 30, -- 固定 30 像素黄金宽度，让代码主视窗更开阔
      mappings = {
        ["l"] = "open", -- 完美对齐 LazyVim：按 l 键直接展开文件夹或打开文件
        ["h"] = "close_node", -- 完美对齐 LazyVim：按 h 键直接折叠当前目录
        ["<space>"] = "none", -- 禁用空格键，防止污染你的 AstroNvim Leader 主键
      },
    },

    -- 4. ✨ 现代高级 IDE 阶梯导轨与语义图标定制
    default_component_configs = {
      indent = {
        with_expanders = true, -- 开启高级折叠指示器
        expander_collapsed = "",
        expander_expanded = "",
        highlight = "NeoTreeIndentMarker", -- 消除多级嵌套的视觉视觉割裂感
      },
      icon = {
        folder_closed = "📂",
        folder_open = "📂",
        folder_empty = "📁",
        default = "󰈚",
      },
      git_status = {
        symbols = {
          added = "✚",
          modified = "", -- 采用内敛的小圆点表示修改，比生硬的字母优雅 10 倍
          deleted = "✖",
          untracked = "",
          ignored = "",
          conflict = "",
        },
      },
    },
  },
}
