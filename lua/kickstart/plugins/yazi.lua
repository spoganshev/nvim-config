return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    {
      '<leader>sy',
      '<cmd>Yazi<cr>',
      mode = { 'n', 'v' },
      desc = 'Open yazi at current file',
    },
    {
      '<leader>sY',
      '<cmd>Yazi cwd<cr>',
      desc = 'Open yazi at cwd',
    },
    {
      '<leader>sR',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume yazi session',
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
