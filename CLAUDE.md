# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Architecture

This is a modular Neovim configuration based on kickstart-modular.nvim, a fork of kickstart.nvim that splits configuration into multiple files for better organization.

### Core Structure

- `init.lua` - Main entry point that loads all modules in order
- `lua/options.lua` - All Neovim options and settings (uses 4-space indentation)
- `lua/keymaps.lua` - Key mappings and autocommands
- `lua/lazy-bootstrap.lua` - Lazy.nvim plugin manager setup
- `lua/lazy-plugins.lua` - Plugin specifications and lazy.nvim configuration

### Plugin Architecture

The configuration uses a modular plugin system:

1. **Core plugins** are defined in `lua/kickstart/plugins/` directory:
   - `telescope.lua` - Fuzzy finder and file navigation
   - `lspconfig.lua` - Language server configuration
   - `blink-cmp.lua` - Completion engine
   - `treesitter.lua` - Syntax highlighting and parsing
   - `gitsigns.lua` - Git integration
   - `conform.lua` - Code formatting
   - `tokyonight.lua` - Color scheme
   - `which-key.lua` - Key binding helper
   - `mini.lua` - Collection of useful mini plugins
   - `todo-comments.lua` - TODO/FIXME highlighting
   - `neo-tree.lua` - File explorer
   - `fugitive.lua` - Git integration

2. **Custom plugins** are in `lua/custom/plugins/`:
   - `fullscreen.lua` - Window fullscreen toggle functionality
   - `init.lua` - Entry point for additional custom plugins (currently empty)

3. **Custom initialization** in `lua/custom/custom-init.lua` contains autocommands and custom setup

### Key Configuration Details

- **Leader key**: Space (`<space>`)
- **Indentation**: 4 spaces (configured in options.lua)
- **Font**: Configured for Nerd Font (`vim.g.have_nerd_font = true`)
- **Clipboard**: Synced with OS clipboard
- **Line numbers**: Enabled with relative numbers
- **Mouse support**: Enabled

### Important Custom Keymaps

- `jk` in insert mode → Exit to normal mode
- `K` in normal mode → Split line at cursor
- `<leader>d` → Delete without yanking (black-hole register)
- `<leader>c` → Change without yanking (black-hole register)
- `<leader>p` (visual) → Paste without overwriting yank register

## Development Commands

### Plugin Management
```bash
nvim  # Start Neovim - Lazy will auto-install plugins on first run
```

Within Neovim:
- `:Lazy` - View plugin status and manage plugins
- `:Lazy update` - Update all plugins
- `:checkhealth` - Run health checks for configuration

### Configuration Validation
- `:Tutor` - Built-in Neovim tutorial (recommended for new users)
- `:help` - Access built-in help system
- `<space>sh` - Search help documentation (via Telescope)

## File Organization Patterns

When adding new functionality:

1. **New plugins** should go in `lua/custom/plugins/` as separate `.lua` files
2. **Custom keymaps** should be added to `lua/keymaps.lua`
3. **Options/settings** should be added to `lua/options.lua`  
4. **Custom initialization logic** should go in `lua/custom/custom-init.lua`

## Dependencies

The configuration requires:
- Neovim (stable or nightly)
- Git, make, unzip, C compiler (gcc)
- ripgrep and fd-find for Telescope
- Clipboard tool (xclip/xsel/win32yank)
- Optional: Nerd Font for icons

## Modular Plugin Loading

Plugins are loaded via `require` statements in `lua/lazy-plugins.lua`. Each plugin file should return a plugin specification table compatible with lazy.nvim.

Example plugin structure:
```lua
-- lua/custom/plugins/example.lua
return {
  'owner/repo-name',
  config = function()
    -- Plugin setup
  end,
}
```