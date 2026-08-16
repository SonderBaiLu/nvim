-- =============================================================================
-- plugins/overseer.lua — 任务运行器（测试 / 构建）
-- =============================================================================

return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo", "OverseerBuild" },
  keys = {
    { "<Leader>or", "<cmd>OverseerRun<cr>", desc = "运行任务" },
    { "<Leader>ot", "<cmd>OverseerToggle<cr>", desc = "切换任务面板" },
    { "<Leader>oi", "<cmd>OverseerInfo<cr>", desc = "任务信息" },
  },
  opts = {
    templates = { "builtin" },
    strategy = "terminal",
    task_list = {
      direction = "bottom",
      min_height = 12,
      max_height = 0.35,
      default_detail = 1,
      bindings = {
        ["?"] = "ShowHelp",
        ["<CR>"] = "RunAction",
        ["e"] = "Edit",
        ["o"] = "Open",
        ["q"] = "Close",
      },
    },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    -- 常用模板：Cargo / npm / vitest
    overseer.register_template({
      name = "Cargo 测试",
      builder = function()
        return { cmd = { "cargo" }, args = { "test" }, components = { "default" } }
      end,
      condition = {
        callback = function()
          return vim.fn.filereadable("Cargo.toml") == 1
        end,
      },
    })
    overseer.register_template({
      name = "npm 测试",
      builder = function()
        return { cmd = { "npm" }, args = { "test" }, components = { "default" } }
      end,
      condition = {
        callback = function()
          return vim.fn.filereadable("package.json") == 1
        end,
      },
    })
    overseer.register_template({
      name = "Cargo 构建",
      builder = function()
        return { cmd = { "cargo" }, args = { "build" }, components = { "default" } }
      end,
      condition = {
        callback = function()
          return vim.fn.filereadable("Cargo.toml") == 1
        end,
      },
    })
  end,
}
