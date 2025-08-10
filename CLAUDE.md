# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Structure

This is a modular Neovim configuration using Lazy.nvim as the plugin manager. The configuration follows a clean separation of concerns pattern with core settings and plugin configurations in separate modules.

### Directory Structure
```
~/.config/nvim/
├── init.lua                 # Entry point - loads core and lazy
├── lazy-lock.json          # Plugin version lock file
└── lua/mario/
    ├── core/               # Core Neovim settings
    │   ├── init.lua       # Loads options and keymaps
    │   ├── options.lua    # Vim options (tabs, search, clipboard, etc.)
    │   └── keymaps.lua    # Core key mappings (leader = space)
    ├── lazy.lua           # Lazy.nvim bootstrap and setup
    └── plugins/           # Individual plugin configurations
```

## Plugin Management

Uses **Lazy.nvim** for plugin management. Plugins are defined in `lua/mario/plugins/` as individual Lua modules that return plugin specs. Lazy automatically loads all files in this directory.

### Key Plugins Configured
- **Telescope**: Fuzzy finder (`<leader>ff`, `<leader>fs`, etc.)
- **nvim-tree**: File explorer
- **nvim-cmp**: Autocompletion with LuaSnip snippets
- **Treesitter**: Syntax highlighting and code understanding
- **BufferLine**: Buffer/tab management
- **auto-session**: Session management
- **which-key**: Keymap helper
- **tokyonight**: Colorscheme