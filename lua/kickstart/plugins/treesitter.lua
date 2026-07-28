return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local languages = {
        'bash',
        'c',
        'diff',
        'go',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      }

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

      -- incremental/decremental selection (replacement for the old
      -- nvim-treesitter incremental_selection module, removed upstream)
      vim.keymap.set({ 'n', 'x', 'o' }, '<Tab>', function()
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require('vim.treesitter._select').select_parent(vim.v.count1)
        else
          vim.lsp.buf.selection_range(vim.v.count1)
        end
      end, { desc = 'Select parent treesitter node or outer incremental lsp selections' })

      vim.keymap.set({ 'x', 'o' }, '<S-Tab>', function()
        require('vim.treesitter._select').select_child(vim.v.count1)
      end, { desc = 'Select child treesitter node (shrink selection)' })
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
