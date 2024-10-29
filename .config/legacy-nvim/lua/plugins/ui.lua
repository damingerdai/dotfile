return {
    {
		"akinsho/bufferline.nvim",
		dependencies = {
			"mini.bufremove",
			"moll/vim-bbye"
		},
		lazy = false,
		-- event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
			{ "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
			{ "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
			{ "<Tab>",      "<Cmd>BufferLineCycleNext<CR>",            desc = "Next tab" },
			{ "<S-Tab>",    "<Cmd>BufferLineCyclePrev<CR>",            desc = "Prev tab" },
			{ "]b",         ":BufferLineCycleNext<CR>",                desc = "Next tab" },
			{ "[b",         ":BufferLineCyclePrev<CR>",                desc = "Prev tab" },
			{ "<leader>bc", ":Bdelete!<CR>", }
		},
		opts = function()
			return {
				options = {
					-- 使用 nvim 内置lsp
					diagnostics = "nvim_lsp",
					-- 左侧让出 nvim-tree 的位置
					offsets = { {
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left"
					} },
					--mode = "tabs",
					-- separator_style = "slant",
					-- show_buffer_close_icons = false,
					-- show_close_icon = false,
				},
			}
		end
	},
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

    -- {
    --     "nvimdev/dashboard-nvim",
    --     event = "VimEnter",
    --     dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    --     config = function()
    --         local logo = [[
    --         .___              .__                                .___      .__
    --         __| _/____    _____ |__| ____    ____   ___________  __| _/____  |__|
    --     / __ |\__  \  /     \|  |/    \  / ___\_/ __ \_  __ \/ __ |\__  \ |  |
    --     / /_/ | / __ \|  Y Y  \  |   |  \/ /_/  >  ___/|  | \/ /_/ | / __ \|  |
    --     \____ |(____  /__|_|  /__|___|  /\___  / \___  >__|  \____ |(____  /__|
    --         \/     \/      \/        \//_____/      \/           \/     \/

    --     ]]
    --         logo = string.rep("\n", 8) .. logo .. "\n\n"
    --         local header = vim.split(logo, "\n")
    --         local config = {
    --             theme = 'hyper',
    --             header = header,
    --         }
    --         require('dashboard').setup {
    --             config
    --         }
    --     end,
    --     -- 	opts = function(_, opts)
    --     -- 		local logo = [[
    --     --         .___              .__                                .___      .__
    --     --         __| _/____    _____ |__| ____    ____   ___________  __| _/____  |__|
    --     --     / __ |\__  \  /     \|  |/    \  / ___\_/ __ \_  __ \/ __ |\__  \ |  |
    --     --     / /_/ | / __ \|  Y Y  \  |   |  \/ /_/  >  ___/|  | \/ /_/ | / __ \|  |
    --     --     \____ |(____  /__|_|  /__|___|  /\___  / \___  >__|  \____ |(____  /__|
    --     --         \/     \/      \/        \//_____/      \/           \/     \/

    --     --   ]]

    --     -- 		logo = string.rep("\n", 8) .. logo .. "\n\n"
    --     -- 		opts.config.header = vim.split(logo, "\n")
    --     -- 	end,
    -- },
}