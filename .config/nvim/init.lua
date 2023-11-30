vim.opt.termguicolors = true

-- 插件管理
require("config.lazy")
-- 快捷键管理
require("config.keymaps")
-- 主题设置
require("colorscheme")

local discipline = require("discipline")

discipline.cowboy()

local has = function(x)
    return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_win = has "win32"
local is_wsl = has "wsl"

if is_mac then
    require('macos')
end

if is_win then
    require('windows')
end

if is_wsl then
    require('wsl')
end
