
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }


-- 基础键位设置
local keymap = vim.api.nvim_set_keymap

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
keymap("n", "<leader>t", ":ToggleTerm<CR>a", opts)
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>:ToggleTerm<CR>]], opts)
  vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- 快速移动
keymap('n', 'f', "<cmd>HopWord<cr>", {})
keymap('n', 'gl', "<cmd>HopLine<cr>", {})
keymap('n', 'gw', "<cmd>HopChar1<cr>", {})
keymap('n', 'gp', "<cmd>HopPattern<cr>", {})
