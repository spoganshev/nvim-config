return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local selections = {
        ['a='] = { '@assignment.outer', 'Select outer part of an assignment' },
        ['i='] = { '@assignment.inner', 'Select inner part of an assignment' },
        ['l='] = { '@assignment.lhs', 'Select left hand side of an assignment' },
        ['r='] = { '@assignment.rhs', 'Select right hand side of an assignment' },
        ['a:'] = { '@property.outer', 'Select outer part of an object property' },
        ['i:'] = { '@property.inner', 'Select inner part of an object property' },
        ['l:'] = { '@property.lhs', 'Select left part of an object property' },
        ['r:'] = { '@property.rhs', 'Select right part of an object property' },
        ['aa'] = { '@parameter.outer', 'Select outer part of a parameter/argument' },
        ['ia'] = { '@parameter.inner', 'Select inner part of a parameter/argument' },
        ['ai'] = { '@conditional.outer', 'Select outer part of a conditional' },
        ['ii'] = { '@conditional.inner', 'Select inner part of a conditional' },
        ['al'] = { '@loop.outer', 'Select outer part of a loop' },
        ['il'] = { '@loop.inner', 'Select inner part of a loop' },
        ['af'] = { '@call.outer', 'Select outer part of a function call' },
        ['if'] = { '@call.inner', 'Select inner part of a function call' },
        ['am'] = { '@function.outer', 'Select outer part of a method/function definition' },
        ['im'] = { '@function.inner', 'Select inner part of a method/function definition' },
        ['ac'] = { '@class.outer', 'Select outer part of a class' },
        ['ic'] = { '@class.inner', 'Select inner part of a class' },
      }
      for key, textobject in pairs(selections) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(textobject[1], 'textobjects')
        end, { desc = textobject[2] })
      end

      local move = require 'nvim-treesitter-textobjects.move'
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        move.goto_next_start('@call.outer', 'textobjects')
      end, { desc = 'Next function call start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next method/function definition start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
        move.goto_next_start('@fold', 'folds')
      end, { desc = 'Next fold' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        move.goto_previous_start('@call.outer', 'textobjects')
      end, { desc = 'Previous function call start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous method/function definition start' })

      local repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'
      vim.keymap.set({ 'n', 'x', 'o' }, ';', repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', repeat_move.repeat_last_move_opposite)
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 't', repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
