return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local languages = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go' }

      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
      }
      require('nvim-treesitter').install(languages, { max_jobs = 1 })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
        callback = function()
          local started = pcall(vim.treesitter.start)
          if started and vim.bo.filetype ~= 'ruby' then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = false,
    keys = {
      { '<leader>tc', '<CMD>TSContext toggle<CR>', desc = 'Toggle treesitter context' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
