local status, masonlsp = pcall(require, "mason-lspconfig")

if not status then
  vim.notify("没有找到 mason-lspconfig")
	return
end


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

-- directly use lspconfig to support dart
require("lspconfig").dartls.setup({
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
      closingLabels = true,
      flutterOutline = true,
      onlyAnalyzeProjectsWithOpenFiles = true,
      outline = true,
      suggestFromUnimportedLibraries = true,
  },
  -- root_dir = root_pattern("pubspec.yaml"),
  settings = {
      dart = {
          completeFunctionCalls = true,
          showTodos = true,
      },
  },
  on_attach = function(client, bufnr)
  end,
})
vim.notify("配置 EslintFixAll")
require("lspconfig").eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.notify("没有找到 EslintFixAll")
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})