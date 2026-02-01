-- Integrate the opencode AI assistant with Neovim
-- https://github.com/nickjvandyke/opencode.nvim

return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
      -- auto_fallback_to_embedded = false,
      provider = {
        enabled = 'tmux',
        tmux = {},
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.keymap.set({ 'n', 'x' }, '<leader>zx', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action...' })

    vim.keymap.set({ 'n', 'x' }, '<leader>za', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode…' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ze', function()
      require('opencode').ask('Explain @this and its context', { submit = true })
    end, { desc = 'Explain...' })

    vim.keymap.set({ 'n', 't' }, '<leader>zt', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })

    vim.keymap.set({ 'n', 'x' }, '<leader>zr', function()
      return require('opencode').operator '@this '
    end, { desc = 'Add range to opencode', expr = true })

    vim.keymap.set('n', '<leader>zl', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Add line to opencode', expr = true })

    -- vim.keymap.set('n', '<S-C-u>', function()
    --   require('opencode').command 'session.half.page.up'
    -- end, { desc = 'Scroll opencode up' })
    --
    -- vim.keymap.set('n', '<S-C-d>', function()
    --   require('opencode').command 'session.half.page.down'
    -- end, { desc = 'Scroll opencode down' })
  end,
}
