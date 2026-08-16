-- =============================================================================
-- plugins/colorscheme.lua — Catppuccin Mocha 统一视觉主题
-- 关联：lualine / bufferline / neo-tree / noice / blink.cmp / gitsigns
-- =============================================================================

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    term_colors = true,
    dim_inactive = { enabled = false },
    integrations = {
      blink_cmp = true,
      bufferline = true,
      cmp = false,
      dap = true,
      dap_ui = true,
      flash = true,
      gitsigns = true,
      indent_blankline = { enabled = true, scope_color = "lavender" },
      lsp_trouble = true,
      mason = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      neotree = true,
      noice = true,
      notify = true,
      telescope = { enabled = true },
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      overseer = true,
      rainbow_delimiters = true,
    },
    custom_highlights = function(colors)
      return {
        NormalFloat = { bg = colors.none },
        FloatBorder = { bg = colors.none, fg = colors.overlay0 },
        FloatTitle = { bg = colors.none, fg = colors.lavender },
        Pmenu = { bg = colors.none },
        PmenuSel = { bg = colors.surface0, fg = colors.text },
        WinSeparator = { fg = colors.surface0 },
        DiagnosticVirtualTextError = { fg = colors.red },
        DiagnosticVirtualTextWarn = { fg = colors.yellow },
        DiagnosticVirtualTextInfo = { fg = colors.sky },
        DiagnosticVirtualTextHint = { fg = colors.teal },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
