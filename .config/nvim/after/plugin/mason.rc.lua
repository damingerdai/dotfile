-- https://github.com/williamboman/mason.nvim 
local status, mason = pcall(require, "mason")
if not status then 
  vim.notify("没有找到 mason")
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
