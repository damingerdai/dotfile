-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.opt.termguicolors = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://mirror.ghproxy.com/https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    vim.notify("没有安装 lazy.nvim")
    return
end

local opts = {
    spec = {
        -- add LazyVim and import its plugins
        {
            "LazyVim/LazyVim",
            import = "lazyvim.plugins",
            opts = {
                ---@type string|fun()
                colorscheme = function()
                    require("tokyonight").load()
                end,
                news = {
                    lazyvim = true,
                    neovim = true,
                },
            },
        },
        { import = "lazyvim.plugins.extras.linting.eslint" },
        { import = "lazyvim.plugins.extras.formatting.prettier" },
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.json" },
        { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.tailwind" },
        { import = "lazyvim.plugins.extras.lang.go" },
        { import = "lazyvim.plugins.extras.coding.copilot" },
        { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
        -- { import = "lazyvim.plugins.extras.coding.yanky" },
        -- { import = "lazyvim.plugins.extras.editor.mini-files" },
        -- { import = "lazyvim.plugins.extras.util.project" },
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    checker = { enabled = true }, -- automatically check for plugin updates
    -- performance = {
    -- 	cache = {
    -- 		enabled = true,
    -- 		-- disable_events = {},
    -- 	},
    -- 	rtp = {
    -- 		-- disable some rtp plugins
    -- 		disabled_plugins = {
    -- 			"gzip",
    -- 			-- "matchit",
    -- 			-- "matchparen",
    -- 			"netrwPlugin",
    -- 			"rplugin",
    -- 			"tarPlugin",
    -- 			"tohtml",
    -- 			"tutor",
    -- 			"zipPlugin",
    -- 		},
    -- 	},
    -- },
    ui = {
        custom_keys = {
            ["<localleader>d"] = function(plugin)
                dd(plugin)
            end,
        },
    },
    debug = false,
    git = {
        url_format = "https://mirror.ghproxy.com/https://github.com/%s.git"
    }
}

lazy.setup("plugins", opts)
