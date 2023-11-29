local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://mirror.ghproxy.com/https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("没有安装 lazy.nvim")
  return
end

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "

local opts = {
  git = {
    url_format = "https://mirror.ghproxy.com/https://github.com/%s.git"
  }
}

lazy.setup("plugins", opts)

