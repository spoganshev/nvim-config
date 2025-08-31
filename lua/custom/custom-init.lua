vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'cd to passed $PWD when vim starts.',
  group = vim.api.nvim_create_augroup('cd-to-pwd', { clear = true }),
  callback = function()
    local pwd = vim.fn.getcwd()
    vim.api.nvim_set_current_dir(pwd)
  end,
})
