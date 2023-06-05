-- -- https://github.com/nvimdev/dashboard-nvim
local dashboard = require("dashboard")
local status, bufferline = pcall(require, "dashboard")
if not status then
  vim.notify("没有找到 dashboard")
  return
end

local empty_line = [[]]

local header = {
    empty_line,
    [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    [[                                                   ]],
    [[                [ version : 1.0.0 ]                ]],
  empty_line
}

local center = {
    {
        icon = "  ",
        desc = "查找文件  ",
        shortcut = "SPC f f",
        action = "Telescope find_files"
    },
    {
        icon = "  ",
        desc = "打开最近的文件",
        shortcut = "SPC f o",
        action = "Telescope oldfiles"
    },
    {
        icon = "  ",
        desc = "打开最近的项目",
        shortcut = "SPC f p",
        action = "Telescope projects"
    },
    {
        icon = "  ",
        desc = "查找单词",
        shortcut = "SPC f w",
        action = "Telescope live_grep"
    },
    {
        icon = "  ",
        desc = "查看标签",
        shortcut = "SPC f m",
        action = "Telescope marks"
    },
    {
        icon = "  ",
        desc = " 打开iterm",
        shortcut = "n",
        action = "FloatermToggle"
    },
    {
        icon = "  ",
        desc = "查看配置",
        shortcut = "ss",
        action = ":e ~/.config/nvim/init.lua <CR>"
    },
   {
        icon = "  ",
        desc = "退出 nvim",
        shortcut = "qa",
        action = ":qa<CR>"
    },
    {icon = '',desc= '开始工作吧', action=''}
}

local footer = {
    "",
    "",
    "https://github.com/nshen/learn-neovim-lua",
}

dashboard.setup({
    theme = 'hyper',
    config = {
        header = header,
        center = center;
        footer = footer;
   }
})