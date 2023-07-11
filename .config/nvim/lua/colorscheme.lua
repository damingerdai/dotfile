vim.o.background = "dark"
vim.g.tokyonight_style = "storm" -- day / night
-- 半透明
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

local colorscheme = "tokyonight"

local status_ok, colorscheme = pcall(require, colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end

local colorscheme = "tokyonight"

local theme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not theme_status_ok then 
  vim.notify("colorscheme:" .. colorscheme .. "加载失败")
end

vim.cmd[[colorscheme tokyonight]]
