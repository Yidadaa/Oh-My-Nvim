require('toggleterm').setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return vim.o.lines * 0.3
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.3
    end
    return 20
  end,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

vim.cmd([[autocmd BufEnter * if &buftype ==# 'terminal' | startinsert! | endif]])
