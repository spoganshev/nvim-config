return {
  { -- Detect tabstop and shiftwidth automatically
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {}
    end,
  },
}
