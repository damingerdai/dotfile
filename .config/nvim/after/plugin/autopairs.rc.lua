local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    vim.notify("没有找到 nvim-autopairs")
    return
end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
