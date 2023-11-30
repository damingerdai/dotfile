return {
    -- messages, cmdline and the popupmenu
    {
        "folke/noice.nvim",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..." entries
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = function(_, opts)
            opts.routes = opts.routes or {}
            table.insert(opts.routes, {
                filter = {
                    event = "notify",
                    find = "No information available",
                },
                opts = { skip = true },
            })
            local focused = true
            vim.api.nvim_create_autocmd("FocusGained", {
                callback = function()
                    focused = true
                end,
            })
            vim.api.nvim_create_autocmd("FocusLost", {
                callback = function()
                    focused = false
                end,
            })
            table.insert(opts.routes, 1, {
                filter = {
                    cond = function()
                        return not focused
                    end,
                },
                view = "notify_send",
                opts = { stop = false },
            })

            opts.commands = {
                all = {
                    -- options for the message history that you get with `:Noice`
                    view = "split",
                    opts = { enter = true, format = "details" },
                    filter = {},
                },
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function(event)
                    vim.schedule(function()
                        require("noice.text.markdown").keys(event.buf)
                    end)
                end,
            })
            if (opts.presets ~= nil) then
                opts.presets.lsp_doc_border = true
            end
        end,
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 5000,
        },
    },
    -- animations
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        opts = function(_, opts)
            opts.scroll = {
                enable = false,
            }
        end,
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                -- globalstatus = false,
                theme = "solarized_dark",
            },
        },
    },

    -- filename
    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        enabled = true,
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("incline").setup({
                highlight = {
                    groups = {
                        InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
                        InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
                    },
                },
                window = { margin = { vertical = 0, horizontal = 1 } },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    return { { icon, guifg = color }, { " " }, { filename } }
                end,
            })
        end,
    },

    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            plugins = {
                gitsigns = true,
                tmux = true,
                kitty = { enabled = false, font = "+2" },
            },
        },
        keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    },

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
        config = function()
            local logo = [[
            .___              .__                                .___      .__
            __| _/____    _____ |__| ____    ____   ___________  __| _/____  |__|
        / __ |\__  \  /     \|  |/    \  / ___\_/ __ \_  __ \/ __ |\__  \ |  |
        / /_/ | / __ \|  Y Y  \  |   |  \/ /_/  >  ___/|  | \/ /_/ | / __ \|  |
        \____ |(____  /__|_|  /__|___|  /\___  / \___  >__|  \____ |(____  /__|
            \/     \/      \/        \//_____/      \/           \/     \/

        ]]
            logo = string.rep("\n", 8) .. logo .. "\n\n"
            local header = vim.split(logo, "\n")
            local config = {
                theme = 'hyper',
                header = header,
            }
            require('dashboard').setup {
                config
            }
        end,
        -- 	opts = function(_, opts)
        -- 		local logo = [[
        --         .___              .__                                .___      .__
        --         __| _/____    _____ |__| ____    ____   ___________  __| _/____  |__|
        --     / __ |\__  \  /     \|  |/    \  / ___\_/ __ \_  __ \/ __ |\__  \ |  |
        --     / /_/ | / __ \|  Y Y  \  |   |  \/ /_/  >  ___/|  | \/ /_/ | / __ \|  |
        --     \____ |(____  /__|_|  /__|___|  /\___  / \___  >__|  \____ |(____  /__|
        --         \/     \/      \/        \//_____/      \/           \/     \/

        --   ]]

        -- 		logo = string.rep("\n", 8) .. logo .. "\n\n"
        -- 		opts.config.header = vim.split(logo, "\n")
        -- 	end,
    },
}
