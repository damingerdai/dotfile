--https://github.com/akinsho/flutter-tools.nvim
local status, flutter = pcall(require, "flutter-tools")
if not status then
  vim.notify("没有找到flutter-tools")
end


flutter.setup({})
