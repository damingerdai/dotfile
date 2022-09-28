-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("正在安装Pakcer.nvim，请稍后...")
    paccker_bootstrap =
        fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1", -- "https://github.com/wbthomason/packer.nvim",
            "https://gitcode.net/mirrors/wbthomason/packer.nvim",
            install_path
        }
    )

    -- https://github.com/wbthomason/packer.nvim/issues/750
    local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
    end
    vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("没有安装 packer.nvim")
    return
end

packer.startup(
    {
        function(use)
            -- 这里是安装插件的位置 TODO:-------->
            use("wbthomason/packer.nvim")
            -- Git
            --use {
            -- 'lewis6991/gitsigns.nvim',
            -- }
            use("ful1e5/onedark.nvim")
            use(
              {
                  "kyazdani42/nvim-tree.lua",
                  requires = "kyazdani42/nvim-web-devicons"
              }
            )

            -- status line
            use("hoob3rt/lualine.nvim")
            -- bufferline
            use(
                {
                    "akinsho/bufferline.nvim",
                    requires = {"kyazdani42/nvim-web-devicons", "moll/vim-bbye"}
                }
            )
            use("kyazdani42/nvim-web-devicons")

            -- dashboard
            use("glepnir/dashboard-nvim")

            --------------------- LSP --------------------
            use({"williamboman/nvim-lsp-installer"})
            -- rust-analyzer and CodeLLDB
            use("williamboman/mason.nvim")
            use("williamboman/mason-lspconfig.nvim")
            -- lsp 加载进度ui
            use("j-hui/fidget.nvim")
            use("arkav/lualine-lsp-progress")
            -- Lspconfig
            use({"neovim/nvim-lspconfig"})
            -- 补全引擎
            use("hrsh7th/nvim-cmp")
            -- Snippet 引擎
            use("hrsh7th/vim-vsnip")
            -- 补全源
            -- UI 增强
            use("tami5/lspsaga.nvim")
            use("onsails/lspkind-nvim")
            use("hrsh7th/cmp-vsnip")
            use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
            use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
            use("hrsh7th/cmp-path") -- { name = 'path' }
            use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
            use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
            -- //拼写建议
            use("f3fora/cmp-spell")

            -- TypeScript 增强
            use({"jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim"})
            -- Lua 增强
            use("folke/lua-dev.nvim")
            -- JSON 增强
            use("b0o/schemastore.nvim")
            -- Rust 增强
            use("simrat39/rust-tools.nvim")
            -- go 语法工具
            use("fatih/vim-go")
            -- prettier
            use('jose-elias-alvarez/null-ls.nvim')
            use('MunifTanjim/prettier.nvim')
            -- Git
            -- [[
            use({'lewis6991/gitsigns.nvim',
                requires = {"nvim-lua/plenary.nvim"}
            })
            --]]

            -- treesitter (新增) 代码高亮
            use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

            -- 切换多个终端
            use("akinsho/toggleterm.nvim")

            if paccker_bootstrap then
                packer.sync()
            end
        end,
        config = {
            -- 最大并发数
            max_jobs = 16,
            -- 自定义源
            git = {
                default_url_format = "https://ghproxy.com/https://github.com/%s"
            }
            -- display = {
            -- 使用浮动窗口显示
            --   open_fn = function()
            --     return require("packer.util").float({ border = "single" })
            --   end,
            -- },
        }
    }
)
