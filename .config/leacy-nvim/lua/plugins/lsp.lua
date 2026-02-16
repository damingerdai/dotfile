return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "tailwindcss-language-server",
        "angular-language-server",
        "css-lsp",
        "prettier",
        "goimports",
        "gopls",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
