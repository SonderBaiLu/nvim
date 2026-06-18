return {
  "stevearc/conform.nvim",
  lazy = false, 
  config = function()
    local conform = require("conform")

    conform.setup({
      -- 1. 按语言映射你的全栈格式化前端工具链 [36]
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        vue = { "prettier" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        conform.format({
          bufnr = args.buf,
          lsp_fallback = true, -- 如果找不到本地二进制工具，自动降级调用 LSP 的格式化能力
          async = false,       -- 必须使用同步或阻塞式极速写入，严防保存时文件产生内存冲突
          timeout_ms = 1000,   -- 超时时间 1 秒，防止遇到超大代码文件时卡死
        })
      end,
    })
  end,
}
