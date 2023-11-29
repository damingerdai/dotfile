local status, luasnip = pcall(require, "luasnip")
if not status then
  vim.notify("没有找到 luasnip")
  return
end

local types = require("luasnip.util.types")

local pathUtils = {}

pathUtils.getData = function()
  return vim.fn.stdpath("data")
end

pathUtils.getConfig = function()
  return vim.fn.stdpath("config")
end

pathUtils.getCache = function()
  return vim.fn.stdpath("cache")
end

pathUtils.join = function(...)
  local path_sep = vim.loop.os_uname().version:match("Windows") and "\\" or "/"
  return table.concat({ ... }, path_sep)
end

-- -- custom snippets
-- pRequire("luasnip.loaders.from_lua").load({
--     paths = pathUtils.join(pathUtils.getConfig(), "lua", "insis", "cmp", "snippets", "lua"),
-- })
require("luasnip.loaders.from_vscode").lazy_load({
    paths = pathUtils.join(pathUtils.getConfig(), "lua", "snippets"),
})
require("luasnip/loaders/from_vscode").lazy_load({
  paths = pathUtils.join(pathUtils.getConfig(), "lua", "snippets"),
})
-- https://github.com/rafamadriz/friendly-snippets/
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip/loaders/from_vscode").lazy_load() 

luasnip.config.set_config({
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
        active = {
            -- virt_text = { { "choiceNode", "Comment" } },
            virt_text = { { "<--", "Error" } },
        },
        },
    },
})
  