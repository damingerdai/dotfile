return {
	-- tools
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			'williamboman/mason-lspconfig.nvim',
			-- Useful status updates for LSP
			{ 'j-hui/fidget.nvim', tag = "legacy", config = true },
			-- Additional lua configuration, makes nvim stuff amazing
			{ 'folke/neodev.nvim', config = true },
			'hrsh7th/cmp-nvim-lsp',
			"mason-registry",
		},
		build = ":MasonUpdate",
		opts = function(_, opts)
			opts.automatic_installation = true
			opts.ensure_installed = opts.ensure_installed or {}
			-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
			vim.list_extend(opts.ensure_installed, {
				'angular-language-server',
				"cssls",
				"cssmodules_ls",
				'dockerls',
				'docker_compose_language_service',
				"eslint",
				"html",
				"jsonls",
				"tsserver",
				"pyright",
				"tailwindcss",
				'rust_analyzer',
				'golangci_lint_ls',
				'gopls',
			})
			opts.ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		end,
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			local masonlsp = require("mason-lspconfig")
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{ "folke/neodev.nvim", opts = {} },

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		opts = {
			inlay_hints = { enabled = false },
			---@type lspconfig.options
			servers = {
				cssls = {},
				tailwindcss = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
				},
				tsserver = {
					root_dir = function(...)
						return require("lspconfig.util").root_pattern(".git")(...)
					end,
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				html = {},
				yamlls = {
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				lua_ls = {
					-- enabled = false,
					single_file_support = true,
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},
				},
			},
			setup = {},
		},
		config = function(_, opts)
			-- inlay_hint
			local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
			if opts.inlay_hints.enabled and inlay_hint then
				inlay_hint(0, true)
			end

			-- servers
			local servers = opts.servers
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)
			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end
			for server, server_opts in pairs(servers) do
				setup(server)
			end
			local lspconfig = require("lspconfig")
			lspconfig.pyright.setup {}
			lspconfig.tsserver.setup {}
			lspconfig.rust_analyzer.setup {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					['rust-analyzer'] = {},
				},
			}
		end,
	},

	-- lsp 加载进度ui
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
	},

	{
		-- TypeScript 增强
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		dependencies = {
			"nvim-lua/plenary.nvim"
		}
	},
	{
		-- Lua 增强
		"folke/neodev.nvim"
	},
	{
		-- JSON 增强
		"b0o/schemastore.nvim"
	},
	{
		-- Rust 增强
		"simrat39/rust-tools.nvim"
	},
	{
		-- go 语法工具
		"fatih/vim-go"
	},
	{
		-- prettier
		"MunifTanjim/prettier.nvim"
	},
	{
		-- eslint
		"MunifTanjim/eslint.nvim"
	}
}
