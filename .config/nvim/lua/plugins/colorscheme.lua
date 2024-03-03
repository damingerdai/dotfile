-- vim.o.background = "dark"
-- vim.g.tokyonight_style = "storm" -- day / night
-- -- 半透明
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true
-- vim.opt.cursorline = true
-- vim.opt.termguicolors = false

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- transparent = true,
      styles = "moon"
    },
  }
}
