--https://github.com/MunifTanjim/prettier.nvim
local status, prettier = pcall(require, "prettier")
if not status then
  vim.notify("没有找到prettier")
end

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
