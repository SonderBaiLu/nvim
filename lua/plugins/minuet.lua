return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "InsertEnter",
  -- 添加一个手动触发的快捷键（这里以 Alt + i 为例）
  keys = {
    {
      "<A-i>",
      function() require("minuet.virtualtext.action").invoke() end,
      mode = "i",
      desc = "手动召唤 AI 补全",
    },
  },
  config = function()
    require("minuet").setup {
      provider = "openai_fim_compatible",
      virtualtext = {
        show_on_completion_menu = true,
        -- 【关键修改】：清空自动触发的文件类型列表，关闭自动弹窗
        auto_trigger_ft = {},
        debounce = 200,
        keymap = {
          accept_line = "<A-a>",
          dismiss = "<A-e>",
          next = "<C-y>",
          prev = "<C-o>",
        },
      },
      provider_options = {
        openai_fim_compatible = {
          api_key = "USER",
          name = "Ollama",
          end_point = "http://127.0.0.1:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          optional = {
            max_tokens = 256,
            num_ctx = 4048,
            stop = { "\n\n" },
            temperature = 0.4,
          },
        },
      },
    }
  end,
}
