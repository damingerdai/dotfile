 -- lsp 加载进度ui
return {
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
          -- options
        },
    },
    {
        "arkav/lualine-lsp-progress"
    }
}