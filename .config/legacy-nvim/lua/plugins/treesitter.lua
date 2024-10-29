return {
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
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
                    "c",
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
                -- https://github.com/nvim-treesitter/playground#query-linter
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { "BufWrite", "CursorHold" },
                },

                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = true, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
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
