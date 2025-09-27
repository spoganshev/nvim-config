-- https://github.com/obsidian-nvim/obsidian.nvim

---@param spec { id: string, dir: obsidian.Path, title: string|? }
---@return string|obsidian.Path The full path to the new note.
local note_path_func = function(spec)
  local path = spec.dir / tostring(spec.title)
  return path:with_suffix '.md'
end

return {
  'obsidian-nvim/obsidian.nvim',
  dependencies = {
    'saghen/blink.cmp',
  },
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
    note_path_func = note_path_func,
    notes_subdir = '100 Zettelkasten',
    new_notes_location = 'notes_subdir',
    templates = {
      folder = '950 Templates',
    },
    completion = (function()
      return {
        nvim_cmp = false,
        blink = true,
        min_chars = 2,
        match_case = true,
        create_new = false,
      }
    end)(),
    footer = {
      -- cool feature, but leads to "too many open files issue"
      enabled = false,
    },
  },
  keys = {
    { '<leader>oo', ':Obsidian<CR>', desc = 'Obsidian command picker', silent = true },
    { '<leader>os', ':Obsidian quick_switch<CR>', desc = 'Obsidian Quick Switch', silent = true },
    { '<leader>oT', ':Obsidian new_from_template<CR>', desc = 'Create Obsidian note from template', silent = true },
    { '<leader>ot', ':Obsidian template<CR>', desc = 'Obsidian: insert template', silent = true },
    { '<leader>oc', ':Obsidian toc<CR>', desc = 'Obsidian: Table of Contents', silent = true },
    { '<leader>ol', ':Obsidian links<CR>', desc = 'Obsidian: Links', silent = true },
    { '<leader>ob', ':Obsidian backlinks<CR>', desc = 'Obsidian: Backlinks', silent = true },
    { '<leader>oO', ':Obsidian open<CR>', desc = 'Obsidian: Open in app', silent = true },
  },
}
