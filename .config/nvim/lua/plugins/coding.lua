return {
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            "f3fora/cmp-spell",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local luasnip = require('luasnip')
            local defaults = require("cmp.config.default")()

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
            })
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end


            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    -- ["<C-e>"] = cmp.mapping.abort(),
                    -- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    -- ["<S-CR>"] = cmp.mapping.confirm({
                    --     behavior = cmp.ConfirmBehavior.Replace,
                    --     select = true,
                    -- }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    -- ["<C-CR>"] = function(fallback)
                    --     cmp.abort()
                    --     fallback()
                    -- end,
                    -- 上一个
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    -- 下一个
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    -- 出现补全
                    ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    -- 取消
                    ["<A-,>"] = cmp.mapping(
                        {
                            i = cmp.mapping.abort(),
                            c = cmp.mapping.close()
                        }
                    ),
                    -- 确认
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm(
                        {
                            select = true,
                            behavior = cmp.ConfirmBehavior.Replace
                        }
                    ),
                    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    -- 如果窗口内容太多，可以滚动
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    -- snippets 跳转
                    ["<C-l>"] = cmp.mapping(
                        function(_)
                            if luasnip.jumpable(1) then
                                luasnip.jump(1)
                            end
                        end,
                        { "i", "s" }
                    ),
                    ["<C-h>"] = cmp.mapping(
                        function()
                            if luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            end
                        end,
                        { "i", "s" }
                    ),
                }),
                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                        group_index = 1,
                        priority = 1000,
                    },
                    {
                        name = "nvim_lsp_signature_help",
                        group_index = 1,
                        priority = 1000,
                    },
                    {
                        name = "luasnip",
                        group_index = 2,
                        priority = 750,
                    },

                    -- { name = "copilot", group_index = 2, priority = 750 },
                    {
                        name = "buffer",
                        group_index = 3,
                        priority = 500,
                    },
                    {
                        name = "path",
                        group_index = 3,
                        priority = 300,
                    },
                    {
                        name = "spell",
                        group_index = 3,
                        priority = 300,
                    },
                }),
                formatting = {
                    format = function(_, item)
                        local icons = require("config.icons").kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = defaults.sorting,
            }
        end,
        ---@param opts cmp.ConfigSchema
        config = function(_, opts)
            local cmp = require("cmp")
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end
            cmp.setup(opts)
            -- Use buffer source for `/`.
            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer" },
                },
            })
            -- Use cmdline & path source for ':'.
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
    {
        "onsails/lspkind-nvim",
        event = "InsertEnter",
        opts = function()
            return {
                -- default: true
                -- with_text = true,
                -- defines how annotations are shown
                -- default: symbol
                -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                mode = "symbol_text",
                -- default symbol map
                -- can be either 'default' (requires nerd-fonts font) or
                -- 'codicons' for codicon preset (requires vscode-codicons font)
                --
                -- default: 'default'
                preset = "codicons",
                -- override preset symbols
                --
                -- default: {}
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            }
        end,
        config = function(_, opts)
            local lspkind = require("lspkind")
            lspkind.init(opts)
        end
    },
    {
        "tami5/lspsaga.nvim",
        dependencies = {

        },
        opts = function()
            return { -- defaults ...
                debug = false,
                use_saga_diagnostic_sign = true,
                -- diagnostic sign
                error_sign = "",
                warn_sign = "",
                hint_sign = "",
                infor_sign = "",
                diagnostic_header_icon = "   ",
                -- code action title icon
                code_action_icon = " ",
                code_action_prompt = {
                    enable = true,
                    sign = true,
                    sign_priority = 40,
                    virtual_text = true,
                },
                finder_definition_icon = "  ",
                finder_reference_icon = "  ",
                max_preview_lines = 10,
                finder_action_keys = {
                    -- open = "o",
                    open = "<CR>",
                    vsplit = "s",
                    split = "i",
                    -- quit = "q",
                    quit = "<ESC>",
                    scroll_down = "<C-f>",
                    scroll_up = "<C-b>",
                },
                code_action_keys = {
                    -- quit = "q",
                    quit = "<ESC>",
                    exec = "<CR>",
                },
                rename_action_keys = {
                    -- quit = "<C-c>",
                    quit = "<ESC>",
                    exec = "<CR>",
                },
                definition_preview_icon = "  ",
                border_style = "single",
                rename_prompt_prefix = "➤",
                rename_output_qflist = {
                    enable = false,
                    auto_open_qflist = false,
                },
                server_filetype_map = {},
                diagnostic_prefix_format = "%d. ",
                diagnostic_message_format = "%m %c",
                highlight_prefix = false,
            }
        end
    },
    {
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows"))
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                local pathUtils = require('path')
                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = pathUtils.join(pathUtils.getConfig(), "lua", "snippets"),
                })
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = function()
            local types = require("luasnip.util.types")

            return {
                history = true,
                --  delete_check_events = "TextChanged",
                update_events = "TextChanged,TextChangedI",
                enable_autosnippets = true,
                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            -- virt_text = { { "choiceNode", "Comment" } },
                            virt_text = { { "<--", "Error" } },
                        },
                    },
                },
            };
        end,
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    }
}
