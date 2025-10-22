return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-go',
    },
    config = function()
      local neotest = require 'neotest'
      neotest.setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            runner = 'pytest',
          },
          require 'neotest-go',
        },
        output_panel = {
          enabled = true,
          open = 'botright vsplit | vertical resize 120',
        },
      }
    end,
    keys = {
      {
        '<leader>Tn',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest Test',
      },
      {
        '<leader>TN',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest Test',
      },
      {
        '<leader>Tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run File Tests',
      },
      {
        '<leader>Ta',
        function()
          require('neotest').run.run { suite = true }
        end,
        desc = 'Run All Tests',
      },
      {
        '<leader>Ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Test Summary',
      },
      {
        '<leader>To',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Open Test Output',
      },
      {
        '<leader>TO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Test Output Panel',
      },
      {
        '<leader>Tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Run Last Test',
      },
      {
        '<leader>Td',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop Test',
      },
    },
  },
}
