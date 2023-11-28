local status, autotag = pcall(require, "nvim-ts-autotag")
if not status then
    vim.notify("没有找到 nvim-ts-autotag")
    return
end

autotag.setup({})