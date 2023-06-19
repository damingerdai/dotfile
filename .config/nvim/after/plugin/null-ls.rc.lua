-- local status, null_ls = pcall(require, "null-ls")
-- if not status then
--   vim.notify("没有找到null-ls")
-- end

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- local lsp_formatting = function(bufnr)
--   vim.lsp.buf.format({
--     filter = function(client)
--       return client.name == "null-ls"
--     end,
--     bufnr = bufnr,
--   })
-- end

-- local fmt = null_ls.builtins.formatting
-- local dgn = null_ls.builtins.diagnostics
-- local cda = null_ls.builtins.code_actions

-- null_ls.setup {
--   sources = {
--    -- Formatting
-- 		fmt.prettierd,
-- 		fmt.eslint_d,
-- 		fmt.prettier.with({
-- 			filetypes = { "html", "json", "yaml", "markdown", "javascript", "typescript" },
-- 		}),
-- 		fmt.stylua,
-- 		fmt.rustfmt,

-- 		-- Diagnostics
-- 		dgn.eslint_d,
-- 		dgn.shellcheck,
-- 		dgn.pylint.with({
-- 			method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
-- 		}),

-- 		-- Code Actions
-- 		cda.eslint_d,
-- 		cda.shellcheck,
--   },
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           lsp_formatting(bufnr)
--         end,
--       })
--     end
--   end
-- }

-- vim.api.nvim_create_user_command(
--   'DisableLspFormatting',
--   function()
--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
--   end,
--   { nargs = 0 }
-- )

require("lspconfig").eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})