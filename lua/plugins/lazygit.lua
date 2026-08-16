-- =============================================================================
-- plugins/lazygit.lua — LazyGit（经 toggleterm 浮动终端启动）
-- =============================================================================

return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<Leader>gg", "<cmd>LazyGit<cr>", desc = "打开 LazyGit" },
    { "<Leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "当前文件 Git 历史" },
  },
  init = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.g.lazygit_use_neovim_remote = 1
  end,
}
