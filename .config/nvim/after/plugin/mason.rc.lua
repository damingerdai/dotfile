-- https://github.com/williamboman/mason.nvim 
local status, mason = pcall(require, "mason")
if not status then 
  vim.notify("没有找到 mason")
end
local status2, masonlsp = pcall(require, "mason-lspconfig")
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


masonlsp.setup({
	automatic_installation = true,
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
	ensure_installed = {
    'angularls',
		"cssls",
    'dockerls',
    'docker_compose_language_service',
		"eslint",
		"html",
		"jsonls",
		"tsserver",
		"pyright",
		"tailwindcss",
    'rust_analyzer',
    'golangci_lint_ls',
    'gopls',
	},
})

