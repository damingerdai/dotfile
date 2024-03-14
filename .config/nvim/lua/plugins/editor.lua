return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = false,
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<leader>er",
                function()
                    vim.cmd "NvimTreeRefresh"
                end,
                desc = "Refresh"
            },
            {
                "<leader>en",
                function()
                    vim.cmd "NvimTreeFindFile"
                end,
                desc = "Find File"
            },
            {
                "<leader>e",
                function()
                    vim.cmd "NvimTreeToggle"
                end,
                desc = "Toggle"
            },
            {
                "<leader>o",
                function()
                    if vim.bo.filetype == "NvimTree" then
                        vim.cmd "wincmd p"
                    else
                        vim.cmd "NvimTreeFocus"
                    end
                end,
                noremap = true,
                silent = true,
            },
            -- {"<leader>r", ":NvimTreeRefresh <CR>", desc = ""},
            -- {"<leader>n", ":NvimTreeFindFile <CR>", desc = ""},
            {
                "<leader>o", 
                function()
                    if vim.bo.filetype == "NvimTree" then
                        vim.cmd.wincmd "p"
                    else
                        vim.cmd("NvimTreeFocus")
                    end
                end,
                noremap = true,
                silent = true,
            },
        },
        opts = {
            -- 隐藏 .文件 和 node_modules 文件夹
            filters = {
                dotfiles = false,
                custom = { "^.git$" }
            },
            disable_netrw = true,
            hijack_netrw = true,
            -- auto_close = false,
            open_on_tab = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = false
            },
            renderer = {
                indent_markers = {
                    enable = true
                },
                add_trailing = true,
                highlight_git = true,
                highlight_opened_files = "none",
                root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
                icons = {
                    show = {
                        -- folders = true,
                        -- files = true,
                        git = true
                    }
                },
                -- 隐藏根目录
                root_folder_label = false,
            },
            view = {
                -- 宽度
                width = 36,
                -- 也可以 'right'
                side = "left",
                -- 自定义列表中快捷键
                -- mappings = {
                --     custom_only = true
                --     --[[ list = list_keys, ]]
                -- },
                -- 不显示行数
                number = false,
                relativenumber = false,
                -- 显示图标
                signcolumn = "yes"
            },
            git = {
                enable = false,
                ignore = false
            },
            actions = {
                open_file = {
                    resize_window = true
                }
            }
        },
    },
    -- {
	-- 	"echasnovski/mini.hipatterns",
	-- 	event = "BufReadPre",
	-- 	opts = {
	-- 		highlighters = {
	-- 			hsl_color = {
	-- 				pattern = "hsl%(%d+,? %d+,? %d+%)",
	-- 				group = function(_, match)
	-- 					local utils = require("colors")
	-- 					local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
	-- 					h, s, l = tonumber(h), tonumber(s), tonumber(l)
	-- 					local hex_color = utils.hslToHex(h, s, l)
	-- 					return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
	-- 				end,
	-- 			},
	-- 		},
	-- 	},
	-- },
    {
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},
	{
		"telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				";f",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({
						no_ignore = false,
						hidden = true,
					})
				end,
				desc = "Lists files in your current working directory, respects .gitignore",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep()
				end,
				desc =
				"Search for a string in your current working directory and get results live as you type, respects .gitignore",
			},
			{
				"\\\\",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Lists open buffers",
			},
			{
				";t",
				function()
					local builtin = require("telescope.builtin")
					builtin.help_tags()
				end,
				desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";e",
				function()
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers or a specific buffer",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
			{
				"sf",
				function()
					local telescope = require("telescope")

					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end

					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "Open File Browser with the path of the current buffer",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions
			opts.defaults = opts.defaults or {}
			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
				mappings = {
					n = {},
				},
			})
			opts.pickers = {
				diagnostics = {
					theme = "ivy",
					initial_mode = "normal",
					layout_config = {
						preview_cutoff = 9999,
					},
				},
			}
			opts.extensions = {
				file_browser = {
					theme = "dropdown",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["n"] = {
							-- your custom normal mode mappings
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["<C-u>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},
}
