return {
  "pysan3/fcitx5.nvim",
  event = "InsertEnter",
  opts = {
    -- 默认只需这些配置即可实现：退出插入模式自动切英文，进入插入模式恢复之前状态
    imname = {
      eng = "keyboard-us",
      -- 这里填写你 Rime 对应的内部名称，通常是 rime 或 pinyin
      zh = "rime",
    },
  },
}
