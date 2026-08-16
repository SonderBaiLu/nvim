-- =============================================================================
-- plugins/lint.lua — nvim-lint（ESLint / Clippy 补充）
-- 说明：Rust Clippy 主要由 rust-analyzer check.command=clippy 提供；
--       此处为 JS/TS/Vue/CSS 等配置 eslint_d
-- =============================================================================

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      -- CSS 可选 stylelint（需项目本地安装时生效）
      css = { "stylelint" },
      scss = { "stylelint" },
    }

    -- 无配置文件时静默跳过，避免刷屏
    local eslint = lint.linters.eslint_d
    if eslint then
      eslint.condition = function(ctx)
        return vim.fs.find({
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
          "eslint.config.ts",
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.json",
          ".eslintrc.yml",
        }, { path = ctx.filename, upward = true })[1] ~= nil
      end
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("SNvimLint", { clear = true }),
      callback = function()
        -- 尝试 lint；缺失二进制时忽略
        pcall(lint.try_lint)
      end,
    })

    vim.keymap.set("n", "<Leader>cl", function()
      lint.try_lint()
      vim.notify("已触发 Lint", vim.log.levels.INFO, { title = "代码检查" })
    end, { desc = "手动触发 Lint" })
  end,
}
