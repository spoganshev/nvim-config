return {
  {
    'nvimtools/none-ls.nvim',
    opts = function()
      local nls = require 'null-ls'
      return {
        sources = {
          nls.builtins.diagnostics.mypy,

          nls.builtins.formatting.gofmt,
        },
      }
    end,
  },
}
