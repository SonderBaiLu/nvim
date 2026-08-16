return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- 进入插入模式时即刻完美加载
  opts = {
    check_ts = true, -- 联动 Treesitter 探测语法环境，严防在字符串或注释里瞎乱配对
    ts_config = {
      lua = { "string" }, -- lua 字符串内不触发
      javascript = { "template_string" }, -- 前端模板字符串内不触发
    },
    fast_wrap = {}, -- 顺带白嫖一个高频神技：Alt + e 自动把括号飞到行尾
  },
  config = function(_, opts)
    local autopairs = require "nvim-autopairs"
    autopairs.setup(opts)

    local Rule = require "nvim-autopairs.rule"
    local cond = require "nvim-autopairs.conds"

    local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
    autopairs.add_rules {
      Rule(" ", " ")
        :with_pair(function(options)
          local pair = options.line:sub(options.col - 1, options.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
          -- 允许在括号内敲空格时，左右自动同步补空格（形如 { cursor }）
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(options)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = options.line:sub(col - 1, col + 2)
          return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
          -- 当你按下 Backspace 删空格时，左右两边的空格同步连带删除
        end),
    }

    for _, bracket in ipairs(brackets) do
      autopairs.add_rules {
        Rule(bracket[1] .. " ", " " .. bracket[2])
          :with_pair(function() return false end)
          :with_move(function(options) return options.char == bracket[2] end)
          :with_del(cond.none())
          :use_key(bracket[2]),
      }
    end
  end,
}
