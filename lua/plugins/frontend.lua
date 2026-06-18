return {
  -- 解决标签同步重命名 (改前面的 <div>，后面的 </div> 自动跟着变)
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter" },
    opts = {
      opts = {
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
    },
  },
}
