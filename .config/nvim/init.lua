-- 基础配置
require("basic")
-- 高亮
require('highlights')
-- Packer插件管理
require("plugins")

-- 主题设置
require("colorscheme")
-- 插件配置
require("plugin-config.nvim-tree")

-- dashboard
-- require("plugin-config.dashboard")
-- bufferline
require('plugin-config/bufferline')

-- Git
require("plugin-config.gitsigns-config")

-- 内置LSP
require("lsp.setup")
--require("lsp.cmp")
--require("lsp.ui")


local has = function(x)
  return vim.fm.has(x) == 1
end
local is_mac = has "macunix"
local is_win = has "win32"
