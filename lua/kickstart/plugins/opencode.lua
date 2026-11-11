-- Integrate the opencode AI assistant with Neovim
-- https://github.com/nickjvandyke/opencode.nvim

return {
  'nickjvandyke/opencode.nvim',
  -- Track `main` (supports OpenCode v2); the stable release line supports v1 only
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      'folke/snacks.nvim',
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = {  -- Enhances `select()`
          actions = {
            opencode_send = function(picker)
              local items = vim.tbl_map(function(item)
                return item.file and require('opencode').format { path = item.file, from = item.pos, to = item.end_pos } or item.text
              end, picker:selected { fallback = true })
              require('opencode').prompt(table.concat(items, ', ') .. ' ')
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local opencode_cmd = 'opencode'
    ---@type snacks.terminal.Opts
    local terminal_opts = { win = { position = 'right', enter = false } }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require('snacks.terminal').open(opencode_cmd, terminal_opts)
        end,
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.keymap.set({ 'n', 'x' }, '<leader>zx', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action...' })

    vim.keymap.set({ 'n', 'x' }, '<leader>za', function()
      require('opencode').ask('@this: ')
    end, { desc = 'Ask opencode…' })

    -- Like `<leader>za`, but lets you pick any session (any directory) to send to.
    vim.keymap.set({ 'n', 'x' }, '<leader>zA', function()
      local function on_error(err)
        if err then
          vim.notify(err, vim.log.levels.ERROR, { title = 'opencode' })
        end
      end
      require('opencode.server.discovery')
        .get()
        :next(function(server)
          local context = require('opencode.context').new(server)
          return require('opencode.ui.ask').ask('@this: ', context):next(function(input)
            -- Builtin contexts format paths relative to cwd; the target session lives
            -- elsewhere, so force absolute paths by hiding cwd while rendering.
            local real_getcwd = vim.fn.getcwd
            vim.fn.getcwd = function()
              return '/__opencode_no_cwd__'
            end
            local ok, rendered = pcall(function()
              return context:render(input).output:plaintext()
            end)
            vim.fn.getcwd = real_getcwd
            assert(ok, rendered)
            local plaintext = rendered
            return server:request('/api/session?order=desc&parentID=null&limit=100', 'GET'):next(function(response)
              local sessions = vim.tbl_filter(function(s)
                return not (s.time and s.time.archived)
              end, response and response.data or {})
              vim.ui.select(sessions, {
                prompt = 'Send to opencode session:',
                format_item = function(s)
                  return (s.title or s.id) .. '  [' .. vim.fn.fnamemodify(s.location.directory, ':~') .. ']'
                end,
              }, function(session)
                if not session then
                  context:resume()
                  return
                end
                server:prompt(session.id, plaintext):next(function()
                  context:clear()
                end):catch(on_error)
              end)
            end)
          end)
        end)
        :catch(on_error)
    end, { desc = 'Ask opencode (pick session)…' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ze', function()
      require('opencode').ask('Explain @this and its context')
    end, { desc = 'Explain...' })

    vim.keymap.set({ 'n', 't' }, '<leader>zt', function()
      require('snacks.terminal').toggle(opencode_cmd, terminal_opts)
    end, { desc = 'Toggle opencode' })

    vim.keymap.set({ 'n', 'x' }, '<leader>zr', function()
      return require('opencode').operator '@this '
    end, { desc = 'Add range to opencode', expr = true })

    vim.keymap.set('n', '<leader>zl', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Add line to opencode', expr = true })
  end,
}
