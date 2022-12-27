-- Auto guess indent on save cpp files
vim.api.nvim_create_augroup('auto_guess_indent', { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = "auto_guess_indent",
  pattern = { "*.*" },
  callback = function()
    vim.cmd("GuessIndent auto_cmd")
  end
})
