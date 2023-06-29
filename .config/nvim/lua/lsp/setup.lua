local lspconfig = require("lspconfig")

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  lua_ls = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
  bashls = require("lsp.config.bash"),
  eslint = require("lsp.config.eslint"),
  -- dartls = require("lsp.config.dart"),
  pyright = require("lsp.config.pyright"),
  html = require("lsp.config.html"),
  cssls = require("lsp.config.css"),
  -- emmet_ls = require("lsp.config.emmet"),
  jsonls = require("lsp.config.json"),
  tsserver = require("lsp.config.ts"),
  rust_analyzer = require("lsp.config.rust"),
  yamlls = require("lsp.config.yamlls"),
  -- remark_ls = require("lsp.config.markdown"),
  -- golangci_lint_ls = require("lsp.config.golangci_lint_ls"),
  gopls = require("lsp.config.gopls"),
  cssmodules_ls = require("lsp.config.cssmodules"),
  volar = require("lsp.config.vue"),
  angularls = require("lsp.config.angular"),
  tailwindcss = require("lsp.config.tailwindcss")
  -- sql  --- https://github.com/lighttiger2505/sql
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end

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


require("lspconfig").eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

