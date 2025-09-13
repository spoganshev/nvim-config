return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      { 'github/copilot.vim' },
    },
    build = 'make tiktoken',
    opts = {
      prompts = {
        Rename = {
          prompt = 'Rename the variable correctly in given selection based on context',
          selection = function(source)
            local select = require 'CopilotChat.select'
            return select.visual(source)
          end,
        },
      },
    },
    keys = {
      { '<leader>zc', ':CopilotChat<CR>', mode = 'n', desc = 'Copilot: Chat' },
      { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Copilot: Explain Code' },
      { '<leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Copilot: Review Code' },
      { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Copilot: Fix code issues' },
      { '<leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Copilot: Optimize code' },
      { '<leader>zd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Copilot: Generate docs' },
      { '<leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Copilot: Generate tests' },
      { '<leader>zm', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Copilot: Generate commit message' },
      { '<leader>zm', ':CopilotChatCommit<CR>', mode = 'v', desc = 'Copilot: Generate commit message' },
    },
    -- config = function()
    --   vim.g.fugitive_gitlab_domains = { ['scm.slicetest.com'] = 'https://scm.slicetest.com' }
    -- end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
