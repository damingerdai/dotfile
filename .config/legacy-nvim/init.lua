-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.opt.termguicolors = true
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

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
