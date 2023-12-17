-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = {
  noremap = true,
  silent = true,
}

-- 本地变量
local keymap = vim.keymap
local map = vim.api.nvim_set_keymap

-- Increment/decrement
map("n", "+", "<C-a>", opt)
map("n", "-", "<C-x>", opt)

-- Delete a word backwards
map("n", "dw", 'vb"_d', { noremap = true, silent = true })

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Select all
map("n", "<C-a>", "gg<S-v>G", opt)

-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opt)
map("v", "g_", "$", opt)
map("n", "$", "g_", opt)
map("n", "g_", "$", opt)

-- 命令行下 Ctrl+j/k  上一个下一个
map("c", "<C-j>", "<C-n>", { noremap = false })
map("c", "<C-k>", "<C-p>", { noremap = false })
-- save file
map("n", "<C-s>", ":w<CR>", opt)

-- fix :set wrap
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)
map("v", "<C-j>", "5j", opt)
map("v", "<C-k>", "5k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "10k", opt)
map("n", "<C-d>", "10j", opt)

-- magic search
-- map("n", "/", "/\\v", { noremap = true, silent = false })
-- map("v", "/", "/\\v", { noremap = true, silent = false })
--
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
map("n", "qq", ":q!<CR>", opt)
map("n", "<leader>q", ":qa!<CR>", opt)
map("n", "<leader>qa", ":quitall<CR>", opt)
map("n", "<leader>q!", ":quitall!<CR>", opt)

-- insert 模式下，跳到行首行尾
-- map("i", "<C-h>", "<ESC>I", opt)
-- map("i", "<C-l>", "<ESC>A", opt)

------------------------------------------------------------------
-- windows 分屏快捷键
------------------------------------------------------------------
-- 取消 s 默认功能
map("n", "s", "", opt)
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt) -- close others
-- alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- <leader> + hjkl 窗口之间跳转
map("n", "<leader>h", "<C-w>h", opt)
map("n", "<leader>j", "<C-w>j", opt)
map("n", "<leader>k", "<C-w>k", opt)
map("n", "<leader>l", "<C-w>l", opt)

-- 上下左右缩放
map("n", "<C-S-Up>", ":resize -2<CR>", opt)
map("n", "<C-S-Down>", ":resize +2<CR>", opt)
map("n", "<C-S-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-S-Right>", ":vertical resize +2<CR>", opt)

-- 相等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
map("n", "st", ":sp | terminal<CR>", opt)
map("n", "stv", ":vsp | terminal<CR>", opt)
-- Esc 回 Normal 模式
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)

map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)

-- lsp÷
-- rename
map("n", "gn", "<cmd>Lspsaga rename<CR>", opt)
-- code action
map("n", "gc", "<cmd>Lspsaga code_action<CR>", opt)

map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)

map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)

map("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)

-- diagnostic
map("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
map("n", "gH", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
map("n", "gw", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opt)
map("n", "gv", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opt)
--
-- nnoremap <leader>xx <cmd>TroubleToggle<cr>
-- nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
-- nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
-- nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
-- nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
-- nnoremap gR <cmd>TroubleToggle lsp_references<cr>
--
--

-- map("n", "gL", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opt)
map("n", "gl", "<cmd>TroubleToggle workspace_diagnostics<CR>", opt)
--------------------------------------------------------------------

-- treesitter 折叠
-- map("n", "zz", ":foldclose<CR>", opt)
-- map("n", "Z", ":foldopen<CR>", opt)
-- 格式化插件
map("n", "<leader>]", "<cmd>Neoformat<CR>", opt)
-- hop
-- word = "mw",
--       line = "ml",
--       char = "ma",
--       charWold = "t + char"
-- hop
map("n", ",w", "<cmd>HopWord<CR>", opt)
map("n", ",a", "<cmd>HopLine<CR>", opt)
map("n", ",c", "<cmd>HopChar1<CR>", opt)

--- go to preview 装逼插件
-- definition = "md",
--         implementation = "mi",
--         all_win = "mc",
--         references = "mr",
--         -- /<leader>gd
--         gotoGile = "gd"

map("n", ",d", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opt)
map("n", ",i", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opt)
map("n", ",q", "<cmd>lua require('goto-preview').close_all_win()<CR>", opt)
map("n", ",r", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opt)

---- spectre

map("n", "]d", "<cmd>lua require('spectre').toggle_line()<CR>", opt)
-- map("n", "<cr>","<cmd>lua require('spectre.actions').select_entry()<CR>", opt )
map("n", "]<cr>", "<cmd>lua require('spectre.actions').select_entry()<CR>", opt)
map("n", "]m", "<cmd>lua require('spectre').show_options()<CR>", opt)
map("n", "]r", "<cmd>lua require('spectre.actions').run_replace()<CR>", opt)
map("n", "]e", "<cmd>lua require('spectre').change_view()<CR>", opt)
map("n", "]o", "<cmd>lua require('spectre').open()<CR>", opt)
map("n", "]s", "viw:lua require('spectre').open_file_search()<CR>", opt)
map("n", "]v", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", opt)

-- nvim-tree
map("n", "<leader>1", ":NvimTreeToggle <CR>", opt)
map("n", "<leader>2", ":NvimTreeFocus <CR>", opt)
map("n", "<leader>e", ":NvimTreeToggle <CR>", opt)
-- map("n", "<leader>o", ":NvimTreeFocus <CR>", opt)
-- nvim_set_keymap 's not mapping it to the lua function directly.
keymap.set("n", "<leader>o", function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd.wincmd("p")
  else
    vim.cmd("NvimTreeFocus")
  end
end, opt)
map("n", "<leader>mr", ":NvimTreeRefresh <CR>", opt)
map("n", "<leader>mf", ":NvimTreeFindFile <CR>", opt)
-- bufferline
-- 左右Tab切换
map("n", "<TAB>", ":BufferLineCycleNext<CR>", opt)
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opt)
map("n", "]b", ":BufferLineCycleNext<CR>", opt)
map("n", "[b", ":BufferLineCyclePrev<CR>", opt)
-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<leader>bc", ":Bdelete!<CR>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opt)

-- Telescope
-- map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- map("n", "<C-f>", ":Telescope live_grep<CR>", opt)
--
map("n", "<leader>fm", ":Telescope marks <CR>", opt)
map("n", "<leader>fb", ":Telescope buffers <CR>", opt)
map("n", "<leader>ff", ":Telescope find_files <CR>", opt)
map("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", opt)
map("n", "<leader>cm", ":Telescope git_commits <CR>", opt)
map("n", "<leader>gt", ":Telescope git_status <CR>", opt)
map("n", "<leader>fh", ":Telescope help_tags <CR>", opt)
map("n", "<leader>fw", ":Telescope live_grep <CR>", opt)
map("n", "<leader>fo", ":Telescope oldfiles <CR>", opt)
map("n", "<leader>fp", ":Telescope projects<CR>", opt)
--  map("n", "<leader>th", ":Telescope themes <CR>", opt)
map("n", "<leader>3", "<cmd>Vista!!<CR>", opt)

-- ctrl + /
map("n", "<C-_>", ",t", { noremap = false })
map("v", "<C-_>", ",t", { noremap = false })
-- map("i", "<C-_>", ",c", { noremap = false })

-- switch
map("n", "g]", ":Switch<cr>", opt)

-- vim_dadbod_ui
-- map("n", "<leader>4", ":DBUIToggle<cr>")
-- todo_comments
-- map("n", , "<cmd>TodoTelescope theme=dropdown<cr>")

map("n", "<leader>td", "<cmd>TodoTelescope theme=dropdown<cr>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
-- 打开普通终端
map("n", "<leader>tb", "<cmd>exe v:count.'ToggleTerm'<CR>", opt)
-- 打开浮动终端
map("n", "<leader>tf", "<cmd>lua require('toggleterm').float_toggle()<CR>", opt)
-- 打开lazy git 终端
map("n", "<leader>tg", "<cmd>lua require('toggleterm').lazygit_toggle()<CR>", opt)
-- 打开或关闭所有终端
map("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", opt)

