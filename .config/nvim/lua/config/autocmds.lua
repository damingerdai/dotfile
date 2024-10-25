-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- -- from https://github.com/AstroNvim/AstroNvim/issues/344
-- -- show neotree on startup
-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   command = "set nornu nonu | Neotree toggle",
-- })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   command = "set rnu nu",
-- })

