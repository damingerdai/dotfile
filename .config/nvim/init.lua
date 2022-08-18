-- 基础配置
require("basic")
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
