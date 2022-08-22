-- 基础配置
require("basic")
-- 高亮
require('highlights')
-- Packer插件管理
require("plugins")
-- 主题设置
require("colorscheme")
-- 内置LSP
require("lsp.setup")
--require("lsp.cmp")
--require("lsp.ui")


local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then 
    require('macos')
end
if is_win then 
    require('windows')
end
