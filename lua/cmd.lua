-- Auto guess indent on save cpp files
vim.api.nvim_create_augroup('auto_guess_indent', { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  group = "auto_guess_indent",
  pattern = { "*.*" },
  callback = function()
    vim.cmd("silent GuessIndent auto_cmd")
  end
})
