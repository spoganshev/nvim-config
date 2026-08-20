return {
  {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_enabled = false
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Suggest()', {
        expr = true,
        replace_keycodes = false,
        desc = 'Copilot: Suggest manually',
      })

      vim.keymap.set('i', '<C-L>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = 'Copilot: Accept suggestion',
      })

      vim.keymap.set('i', '<M-l>', 'copilot#AcceptWord()', {
        expr = true,
        replace_keycodes = false,
        desc = 'Copilot: Accept next word',
      })

      vim.keymap.set('n', '<leader>tC', function()
        if vim.g.copilot_enabled == false or vim.g.copilot_enabled == 0 then
          vim.cmd('Copilot enable')
        else
          vim.cmd('Copilot disable')
        end
      end, { desc = 'Toggle Copilot' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
