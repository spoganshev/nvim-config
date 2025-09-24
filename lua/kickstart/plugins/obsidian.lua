-- https://github.com/obsidian-nvim/obsidian.nvim
return {
  'obsidian-nvim/obsidian.nvim',
  lazy = false,
  version = '*', -- recommended, use latest release instead of latest commit
  -- ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    -- see full list of options here: https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua
    workspaces = {
      {
        name = 'Notes',
        path = '~/Notes',
      },
    },
    legacy_commands = false,
    disable_frontmatter = true,
  },
  keys = {
    { '<leader>os', ':Obsidian quick_switch<CR>', desc = 'Obsidian Quick Switch', silent = true },
  },
}
