return {
  {
    -- See https://github.com/tpope/vim-fugitive (Git wrapper for NVIM)
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      { '<leader>hB', ':GBrowse<CR>', desc = 'git [B]rowse', silent = true },
    },
  },
  {
    -- Fugitive plugin for GitHub
    'tpope/vim-rhubarb',
  },
  {
    -- Fugitive plugin for GitLab
    'shumphrey/fugitive-gitlab.vim',
    config = function()
      vim.g.fugitive_gitlab_domains = { ['scm.slicetest.com'] = 'https://scm.slicetest.com' }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
