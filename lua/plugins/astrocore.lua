---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- 1. 核心功能开关 (配置 AstroNvim 的核心特性)
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- 大文件全局限制（超过此大小禁用语法高亮等，防卡顿）
      autopairs = true, -- 启动时启用自动括号匹配
      cmp = true, -- 启动时启用代码自动补全
      diagnostics = { virtual_text = true, virtual_lines = false }, -- 启动时的代码诊断（报错提示）设置
      highlighturl = true, -- 启动时高亮 URL 链接
      notifications = true, -- 启用右下角的通知弹窗
    },

    -- 2. 代码诊断 (报错和警告的具体显示方式)
    diagnostics = {
      virtual_text = true, -- 在代码行尾显示虚拟文字报错
      underline = true, -- 在错误代码下方画波浪线
    },

    -- 3. 自定义文件类型 (识别特殊后缀名，暂时用不到可以放着不管)
    filetypes = {
      extension = { foo = "fooscript" },
      filename = { [".foorc"] = "fooscript" },
      pattern = { [".*/etc/foo/.*"] = "fooscript" },
    },

    -- 4. Vim 基础选项配置 (控制编辑器最基础的显示行为)
    options = {
      opt = {
        relativenumber = true, -- 开启相对行号（方便代码上下跳跃跳转）
        number = true, -- 显示当前行号
        spell = false, -- 关闭默认的英文拼写检查（去除烦人的单词下划线）
        signcolumn = "yes", -- 始终显示左侧标记列（用来显示 Git 修改状态、断点等）
        wrap = true, -- 关闭自动折行（长代码不换行，超出屏幕范围）
        showbreak = "↳ ",
        tabstop = 2, -- Tab 占 2 个空格（前端常规规范）
        shiftwidth = 2, -- 缩进为 2 个空格
      },
      g = {
        -- 全局变量配置区 (对应 vim.g.xxx)
      },
    },

    -- 5. 快捷键映射 (Mappings)
    mappings = {
      n = { -- n 代表 Normal (普通模式)

        -- 切换顶部标签页 (Buffer)
        ["<C-o>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "下一个标签页" },
        ["<C-i>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "上一个标签页" },

        -- 从顶部标签栏交互式关闭文件
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "交互式关闭标签页",
        },
        ["<Leader>b"] = { desc = "󰓩 缓冲区 (Buffers)" },
        ["<Leader>f"] = { desc = "󰍉 查找 (Find)" },
        ["<Leader>g"] = { desc = "󰊢 Git 版本控制" },
        ["<Leader>l"] = { desc = "󰒋 语言服务 (LSP)" },
        ["<Leader>p"] = { desc = "󰏖 插件管理 (Packages)" },
        ["<Leader>s"] = { desc = "󰒓 搜索会话 (Search)" },
        ["<Leader>u"] = { desc = "󰠠 界面与工具 (UI)" },
        ["<Leader>w"] = { desc = "󰖚 窗口布局 (Windows)" },
        ["<Leader>x"] = { desc = "󰅙 错误诊断 (Diagnostics)" },
        ["<Leader>c"] = { "<cmd>bdelete<cr>", desc = "󰅖 关闭当前文件" },
        ["<C-s>"] = { "<cmd>w<cr>", desc = "保存文件" },
      },
      i = { -- i 代表 Insert (插入模式，即正在打字写代码的状态)
        ["<C-s>"] = { "<esc><cmd>w<cr>", desc = "保存文件" },
      },
    },
  },
}
