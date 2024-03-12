return {
    -- tools
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- Useful status updates for LSP
            { "j-hui/fidget.nvim", tag = "legacy", config = true },
            -- Additional lua configuration, makes nvim stuff amazing
            { "folke/neodev.nvim", config = true },
            "hrsh7th/cmp-nvim-lsp",
            "mason-registry",
        },
        build = ":MasonUpdate",
        opts = function(_, opts)
            opts.automatic_installation = true
            opts.ensure_installed = opts.ensure_installed or {}
            -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            vim.list_extend(opts.ensure_installed, {
                "angular-language-server",
                "css-lsp",
                "cssmodules-language-server",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "eslint-lsp",
                "html-lsp",
                "json-lsp",
                "typescript-language-server",
                "pyright",
                "tailwindcss-language-server",
                "rust-analyzer",
                "golangci-lint",
                "gopls",
                -- "rust_analyzer",
            })
            opts.ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            }
        end,
    },
    {
        "folke/neodev.nvim",
        opts = {}
    },

    -- lsp servers
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        opts = {
            inlay_hints = { enabled = false },
            ---@type lspconfig.options
            servers = {
                astro = {},
                angularls = {},
                cssls = {},
                html = {},
                ["rust_analyzer"] = {
                    cargo = {
                        loadOutDirsFromCheck = true,
                    },
                    procMacro = {
                        enable = true,
                    },
                    -- enable clippy on save
                    checkOnSave = {
                        command = "clippy"
                    },
                    settings = {
                        ["rust-analyzer"] = {

                        },
                    },
                },
            }
        }
    },

    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.docker" },

    -- lsp 加载进度ui
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        "arkav/lualine-lsp-progress",
    },
    {
        -- Rust 增强
        "simrat39/rust-tools.nvim",
    },
    {
        "rust-lang/rust.vim",
    },
    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            src = {
                cmp = { enabled = true },
            },
        },
    },
    {
        -- go 语法工具
        "fatih/vim-go",
    },
    {
        -- prettier
        "MunifTanjim/prettier.nvim",
    },
    {
        -- eslint
        "MunifTanjim/eslint.nvim",
    },
}
