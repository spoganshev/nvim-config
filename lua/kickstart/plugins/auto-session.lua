return {
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      auto_restore = false,
      suppressed_dirs = { '~/', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
    keys = {
      { '<leader>wr', '<cmd>AutoSession restore<CR>', desc = 'Restore session' },
      { '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
    },
  },
}
