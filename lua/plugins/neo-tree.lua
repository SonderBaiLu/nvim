return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- 这个设为 true，即使匹配了过滤规则的文件也会变灰显示，而不是彻底消失
        hide_dotfiles = false, -- 彻底关闭隐藏 . 开头文件的功能
        hide_gitignored = false, -- (可选) 如果你希望被 .gitignore 忽略的文件也能显示出来，把这个也设为 false
      },
    },
  },
}
