-- The mason-lspconfig.mappings.server module was never really public, the recommended stable interface would be:
-- require("mason-lspconfig").get_mappings().lspconfig_to_package
-- -- or alternatively (although not technically a public API)
-- require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package
-- solution: https://github.com/LazyVim/LazyVim/issues/6039
return {
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
