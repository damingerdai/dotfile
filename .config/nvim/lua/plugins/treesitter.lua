return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = function()
            return {
                highlight = {
                    enable = true,
                    disable = {},
                },
                indent = {
                    enable = true,
                    disable = {},
                },
                ensure_installed = {
                    "tsx",
                    "toml",
                    "json",
                    "yaml",
                    "css",
                    "html",
                    "lua",
                    "dockerfile",
                    "dot",
                    "go",
                    "javascript",
                    "rust",
                    "scss",
                    "sql",
                    "typescript",
                },
                autotag = {
                    enable = true,
                },
            }
        end,
        config = function(_, opts)
            local status, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
            if not status then
                vim.notify("没有找到 nvim-teesitter")
                return
            end
            nvim_treesitter.setup(opts)
            local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
        end
    }
}
