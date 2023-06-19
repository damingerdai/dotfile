-- https://github.com/williamboman/mason.nvim 
local status, mason = pcall(require, "mason")
if not status then 
  vim.notify("没有找到 mason")
end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then 
    vim.notify("没有找到 mason-lspconfig")
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

lspconfig.setup {
    automatic_installation = true
  }
