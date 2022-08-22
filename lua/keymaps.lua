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

-- Normal 模式下，Esc 清空高亮
keymap('n', '<esc>', ':noh<cr>', opts)

-- bd 关闭 buffer
keymap('n', 'bd', ':bd<cr>', opts)

-- 使用 ctrl + arrow 调整窗口
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- 使用 jk/kj/jj 退出 insert 模式
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "jj", "<ESC>", opts)

-- Telescoe 搜索快捷键
keymap("n", "<leader><leader>", ":Telescope find_files<CR>", opts)

-- Terminal
comp_key_map("n", "=", ":ToggleTerm<CR>a<BS>")
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
  comp_key_map("t", "=", [[<C-\><C-n>:ToggleTerm<CR>]])
  vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
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
