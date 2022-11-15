local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local utils = require('utils')

-- 基础键位设置
local keymap = vim.api.nvim_set_keymap

-- 为 Meta / Alt 分配键位，从而使得 Windows 和 Mac 的体验一致
function comp_key_map(mode, key, command)
  local lead_keys = { 'M', 'A' }
  for _, lead in pairs(lead_keys) do
    local key = string.format('<%s-%s>', lead, key)
    keymap(mode, key, command, opts)
  end
end

-- 使用空格作为 leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 快速重载配置
keymap("n", "<leader><CR>", ":luafile $MYVIMRC<CR>", opts)

-- 一些模式
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- 使用 ctrl + hjkl 导航窗口
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- 把 shift + u/d 也映射为 ctrl + u/d，防止手滑
keymap("n", "<S-u>", "<C-u>", opts)
keymap("n", "<S-d>", "<C-d>", opts)

-- Normal 模式下，Esc 清空高亮
keymap('n', '<esc>', ':noh<cr>', opts)

-- 使用 shift + arrow 调整窗口
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- 使用 kj 退出 insert 模式
keymap("i", "kj", "<ESC>", opts)

-- Telescoe 搜索快捷键
keymap("n", "<leader><leader>", ":Telescope find_files<CR>", opts)

-- Terminal
comp_key_map("n", "=", ":ToggleTerm<CR>")
function _G.set_terminal_keymaps()
  local term_opts = { buffer = 0 }
  local exit_term = [[q<BS><C-\><C-n>:ToggleTerm<CR>]]
  vim.keymap.set('t', '<esc><esc>', exit_term, term_opts)
  comp_key_map("t", "=", exit_term)
  vim.keymap.set('t', 'kj', [[<C-\><C-n>]], term_opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- 快速移动
keymap('n', 'f', "<cmd>HopChar1<cr>", opts)

-- 命令窗口
comp_key_map('n', 'p', ":Telescope command_center<cr>")
keymap('n', '<leader>p', "<cmd>Telescope command_center<cr>", opts)

-- 搜索
keymap('n', '/', ':SearchBoxMatchAll<cr>', opts) -- normal 模式下使用 search box 搜索
keymap('v', '/', [[y:SearchBoxMatchAll <C-R>=escape(@",'/\')<cr><cr>]], opts) -- visual 模式下自动搜索选中的文本

-- 禁用 vim viusal multi 的左右选中快捷键
vim.cmd [[
let g:VM_default_mappings = 0
]]
