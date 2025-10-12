-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

vim.keymap.set('n', 'K', 'i<CR>', { noremap = true, silent = true, desc = 'Split the line' })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true, desc = 'Exit insert mode by pressing jk' })

-- Delete/change/paste without yanking --
-- Delete without yanking (normal mode)
vim.keymap.set('n', '<leader>d', '"_d', { noremap = true, silent = true, desc = 'Delete without yanking (black-hole)' })
-- Delete without yanking (visual mode)
vim.keymap.set('v', '<leader>d', '"_d', { noremap = true, silent = true, desc = 'Visual delete without yanking (black-hole)' })
-- Change without yanking (normal mode)
vim.keymap.set('n', '<leader>c', '"_c', { noremap = true, silent = true, desc = 'Change without yanking (black-hole)' })
-- Replace selection without overwriting yank (visual mode)
vim.keymap.set('v', '<leader>c', '"_c', { noremap = true, silent = true, desc = 'Visual change without yanking (black-hole)' })
-- Replace selection without overwriting yank (visual mode)
vim.keymap.set('v', '<leader>p', '"_dP', { noremap = true, silent = true, desc = 'Paste over selection without yanking it' })

-- Toggle fullscreen
local fullscreen = require 'custom.plugins.fullscreen'
local toggle_fullscreen = function()
  fullscreen:toggle_fullscreen()
end
vim.keymap.set('n', '<leader>tf', toggle_fullscreen, { noremap = true, silent = true, desc = 'Toggle fullscreen window' })

vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local yank_path = function(to_expand)
  local filepath = vim.fn.expand(to_expand)
  vim.fn.setreg('+', filepath) -- write to clippoard
end

vim.keymap.set('n', '<leader>yp', function()
  yank_path '%:t'
end, { desc = 'Yank: Copy current file name to clipboard' })
vim.keymap.set('n', '<leader>yP', function()
  yank_path '%'
end, { desc = 'Yank: Copy current file path to clipboard' })

-- snippets to insert as code
vim.keymap.set('n', '<leader>ipm', 'A  # type: ignore[]', { desc = 'Insert Python: mypy ignore' })
vim.keymap.set('n', '<leader>ipp', 'A  # pylint: disable=[]', { desc = 'Insert Python: pylint disable' })

-- insert current date:
vim.keymap.set('n', '<leader>id', function()
  local date = os.date '%Y-%m-%d'
  vim.api.nvim_put({ date }, 'c', true, true)
end, { desc = 'Insert current date' })
-- vim: ts=2 sts=2 sw=2 et
