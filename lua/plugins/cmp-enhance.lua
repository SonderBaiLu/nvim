return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' }, -- Ctrl+k 补全列表向上移动
        ['<C-j>'] = { 'select_next', 'fallback' }, -- Ctrl+j 补全列表向下移动
        ['<CR>'] = { 'accept', 'fallback' },        -- 回车键 确认补全
      },
      appearance = {
        -- 'mono' (Nerd Font Mono) 或 'normal' (Nerd Font)
        -- 这里调整为 mono 可以确保图标在弹出框中完美对齐
        nerd_font_variant = "mono",
        kind_icons = {
          -- 核心逻辑与结构 (高辨识度几何图形)
          Class = "", -- 菱形块
          Interface = "", -- 穿透的菱形
          Struct = "", -- 结构体专属
          Module = "󰏗", -- 模块箱子
          TypeParameter = "", -- 类型参数 T
          -- 函数与方法
          Function = "󰡱", -- 圆形函数符
          Method = "", -- 方块方法符
          Constructor = "", -- 构造扳手
          -- 变量与属性
          Variable = "", -- 明确的变量标识 x
          Constant = "", -- 锁定的常量
          Property = "", -- 扳手属性
          Field = "", -- 字段标记
          -- 基础元素
          Text = "", -- 文本 A
          String = "", -- 字符串
          Number = "", -- 数字
          Boolean = "", -- 布尔
          Array = "", -- 数组括号
          Object = "", -- 对象大括号
          -- 其他关键字与控制流
          Keyword = "", -- 钥匙
          Operator = "", -- 运算符号 + -
          Event = "", -- 闪电事件
          Reference = "", -- 引用链接
          Enum = "", -- 枚举列表
          EnumMember = "", -- 枚举成员
          -- 杂项
          Snippet = "", -- 代码片段剪影
          Color = "", -- 调色盘
          File = "", -- 文件
          Folder = "", -- 文件夹
          Unit = "", -- 单位尺
          Value = "", -- 值
          -- AI 辅助编程专属图标 (直接支持)
          Copilot = "", -- Github Copilot
          Codeium = "", -- Codeium
          TabNine = "󰏚", -- TabNine
          Supermaven = "", -- Supermaven
        },
      },
      completion = {
        menu = {
          -- 补全列表的边框，可选 "single", "rounded", "double", "solid" 等
          border = "single",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          scrollbar = false, -- 隐藏右侧 滚动条
          draw = {
            -- 调整列间距，让图标、代码、说明之间有呼吸感
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
            treesitter = { "lsp" }, -- 开启树结构的高亮支持
          },
        },
        documentation = {
          auto_show = true,
          -- 加一点点延迟，避免你在快速敲击键盘时右侧文档框疯狂闪烁
          auto_show_delay_ms = 200,
          window = {
            -- 右侧代码文档详情框的边框
            border = "single",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            scrollbar = false,
          },
        },
      },
    },
  },
}
