-- =============================================================================
-- plugins/telescope.lua — 模糊查找（中文提示符）
-- =============================================================================

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = require("S").is_windows and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        or "make",
      cond = function()
        return vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1
      end,
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        prompt_prefix = " 查找   ",
        selection_caret = " ",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          width = 0.87,
          height = 0.80,
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "target/",
          "dist/",
          "build/",
          "%.lock",
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = { additional_args = { "--hidden" } },
        buffers = { sort_mru = true, ignore_current_buffer = true },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension, "fzf")
  end,
}
