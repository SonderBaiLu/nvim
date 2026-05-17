-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.lua" },
  -- 前端全家桶
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.vue" }, -- 自动处理 Volar 和 TS
  { import = "astrocommunity.pack.html-css" }, -- 包含 SCSS 和 Emmet
}
