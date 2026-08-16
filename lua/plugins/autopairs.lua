-- =============================================================================
-- plugins/autopairs.lua — 自动括号（联动 Treesitter / blink.cmp）
-- =============================================================================

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      typescript = { "template_string" },
    },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      highlight = "Search",
    },
    disable_filetype = { "TelescopePrompt", "vim" },
  },
  config = function(_, opts)
    local autopairs = require("nvim-autopairs")
    autopairs.setup(opts)

    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")
    local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

    autopairs.add_rules({
      Rule(" ", " ")
        :with_pair(function(options)
          local pair = options.line:sub(options.col - 1, options.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(options)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = options.line:sub(col - 1, col + 2)
          return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
        end),
    })

    for _, bracket in ipairs(brackets) do
      autopairs.add_rules({
        Rule(bracket[1] .. " ", " " .. bracket[2])
          :with_pair(function()
            return false
          end)
          :with_move(function(options)
            return options.char == bracket[2]
          end)
          :with_del(cond.none())
          :use_key(bracket[2]),
      })
    end
  end,
}
