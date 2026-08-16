-- =============================================================================
-- plugins/dap.lua — 调试：nvim-dap + dap-ui（中文）
-- 支持：Rust（codelldb）、TypeScript/JavaScript（js-debug-adapter）
-- 关联：mason-tool-installer 安装适配器
-- =============================================================================

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          {
            "<Leader>du",
            function()
              require("dapui").toggle({})
            end,
            desc = "切换调试界面",
          },
          {
            "<Leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "求值表达式",
            mode = { "n", "v" },
          },
        },
        opts = {
          controls = { enabled = true },
          floating = { border = "rounded" },
          layouts = {
            {
              elements = {
                { id = "scopes", size = 0.30 },
                { id = "breakpoints", size = 0.20 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
              },
              size = 40,
              position = "left",
            },
            {
              elements = { "repl", "console" },
              size = 0.25,
              position = "bottom",
            },
          },
        },
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = { commented = true },
      },
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      {
        "<Leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "切换断点",
      },
      {
        "<Leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("断点条件: "))
        end,
        desc = "条件断点",
      },
      {
        "<Leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "继续/启动调试",
      },
      {
        "<Leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "单步进入",
      },
      {
        "<Leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "单步跳过",
      },
      {
        "<Leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "单步跳出",
      },
      {
        "<Leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "调试 REPL",
      },
      {
        "<Leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "终止调试",
      },
    },
    config = function()
      local dap = require("dap")
      local S = require("S")

      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "js" },
        automatic_installation = true,
        handlers = {},
      })

      -- 中文断点标志
      vim.fn.sign_define("DapBreakpoint", { text = "断", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "条", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "停", texthl = "DiagnosticInfo" })

      -- Rust / C++：codelldb
      local mason_registry = require("mason-registry")
      local function get_codelldb()
        local ok, pkg = pcall(mason_registry.get_package, "codelldb")
        if not ok then
          return nil, nil
        end
        local install = pkg:get_install_path()
        if S.is_windows then
          return S.join(install, "extension", "adapter", "codelldb.exe"), S.join(install, "extension", "lldb", "bin")
        end
        return S.join(install, "extension", "adapter", "codelldb"), S.join(install, "extension", "lldb", "lib")
      end

      local codelldb, liblldb = get_codelldb()
      if codelldb then
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = codelldb,
            args = { "--port", "${port}" },
          },
        }
        dap.configurations.rust = {
          {
            name = "启动 Rust 程序",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("可执行文件路径: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
        }
      end

      -- JS / TS：js-debug-adapter（vscode-js-debug）
      local js_ok, js_pkg = pcall(mason_registry.get_package, "js-debug-adapter")
      if js_ok then
        local debugger = S.join(js_pkg:get_install_path(), "js-debug", "src", "dapDebugServer.js")
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = { debugger, "${port}" },
          },
        }
        for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
          dap.configurations[lang] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "启动当前文件",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "附加到进程",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end

      _ = liblldb -- 预留扩展
    end,
  },
}
