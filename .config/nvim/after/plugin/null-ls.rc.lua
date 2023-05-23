--https://github.com/MunifTanjim/prettier.nvim
-- local lspConfigStatus, lspconfig = pcall(require, "lspconfig")
-- if not lspConfigStatus then 
--   vim.notify("没有找到lspconfig");
-- end
local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到null-ls")
end


-- lspconfig.tsserver.setup({
--     on_attach = function(client, bufnr)
--         client.resolved_capabilities.document_formatting = false
--         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
--     end,
-- })


null_ls.setup({
    on_attach = function(client, bufnr)
    --if client.resolved_capabilities.document_formatting then
		--  vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		--end
    -- client.resolved_capabilities.document_formatting = false
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
    -- if client.server_capabilities.documentFormattingProvider then
    --   vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")

    --   -- format on save
    --   vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    -- end

    -- if client.server_capabilities.documentRangeFormattingProvider then
    --   vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    -- end
  end,
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.formatting.eslint_d.with({
      -- diagnostics_format = '[eslint] #{m}\n(#{c})',
      args = { "--fix", "--format", "json", "--stdin", "--stdin-filename", "$FILENAME" }
    }),    
    null_ls.builtins.diagnostics.fish
  }
})

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)
