-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree toggle last<CR>', desc = 'NeoTree toggle last source', silent = true },
  },
  opts = function()
    -- Grep inside the node under cursor (directory itself, or a file's parent dir)
    local function node_dir(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      if node.type ~= 'directory' then
        path = vim.fn.fnamemodify(path, ':h')
      end
      return path
    end

    return {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<leader>sg'] = 'grep_in_dir',
          ['<leader>sG'] = 'grep_hidden_in_dir',
        },
      },
      commands = {
        grep_in_dir = function(state)
          local dir = node_dir(state)
          require('telescope.builtin').live_grep { search_dirs = { dir }, prompt_title = 'Live Grep: ' .. vim.fn.fnamemodify(dir, ':~') }
        end,
        grep_hidden_in_dir = function(state)
          local dir = node_dir(state)
          _G.telescope_grep_hidden { search_dirs = { dir }, prompt_title = 'Live Grep (hidden): ' .. vim.fn.fnamemodify(dir, ':~') }
        end,
      },
    }
  end,
}
