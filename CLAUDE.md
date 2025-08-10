# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Global GitHub Rules
@/Users/mario/github-rules.md

## Current Task: Push to GitHub Repository

### Completed Steps:
1. ✅ Fixed typo in `lua/mario/core/options.lua` (line 6: `tue` → `true`)
2. ✅ Initialized git repository in `/Users/mario/.config/nvim/`
3. ✅ Created `.gitignore` that excludes `.claude/` directory
4. ✅ Added all files and created initial commit
5. ✅ **GitHub repository created** - Repository "nvim-config" exists on GitHub
6. ✅ **Added remote origin** - https://github.com/mario-digital/nvim-config.git
7. ✅ **Pushed to GitHub** - Repository successfully pushed to main branch

### Important Context:
- User stores secrets in macOS Keychain (loaded via `~/.zshrc.local`)
- Token was `GITHUB_CLAUDE_CODE_ACCESS_TOKEN`, user is creating `GITHUB_TOKEN`
- Repository is ready to push (committed on main branch)

## GitHub Workflow Preferences

### Use GitHub MCP for:
- **Creating repositories**: `mcp__github__create_repository`
- **Creating branches**: `mcp__github__create_branch`
- **Checking repository status**: `mcp__github__list_branches`, etc.
- **Pull requests**: Creating, reviewing, merging PRs
- **Issues**: Creating, updating, commenting on issues
- **Reading files from GitHub**: `mcp__github__get_file_contents`

### Use Git CLI for:
- **Local commits**: `git add`, `git commit -m "message"`
- **Pushing changes**: `git push origin <branch>`
- **Local branch operations**: `git checkout`, `git merge`
- **Stashing**: `git stash`, `git stash pop`
- **Rebasing**: `git rebase`
- **Local status checks**: `git status`, `git diff`

### Use GitHub CLI (gh) for:
- **Deleting repositories**: `gh repo delete owner/repo --yes`
- **Changing repository visibility**: `gh repo edit owner/repo --visibility private --accept-visibility-change-consequences`
- Note: These operations are not available in GitHub MCP for safety reasons

This approach leverages GitHub MCP for repository management while maintaining familiar git workflows for local development.

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

## Neovim Usage Guide

### Navigation with Relative Line Numbers
**IMPORTANT**: This config uses `relativenumber = true`, which means:
- Numbers shown on lines are **relative distances** from cursor
- `4j` jumps to the line showing "4" below cursor
- `4k` jumps to the line showing "4" above cursor
- The relative numbers ARE the jump targets - use them directly with j/k

### Essential Keybindings
**Leader key = SPACE**

#### File Navigation
- `<Space>ff` - Find files (Telescope)
- `<Space>fs` - Search text in files (live grep)
- `<Space>e` - Toggle file explorer (nvim-tree)

#### Line Navigation
- `10G` or `10gg` - Jump to absolute line 10
- `4j` - Jump down to line showing "4" (relative)
- `4k` - Jump up to line showing "4" (relative)
- `gg` - First line of file
- `G` - Last line of file
- `:42` - Jump to line 42

#### Editing
- `dd` - Delete line (and copy to clipboard)
- `yy` - Copy line
- `p` - Paste after cursor/line
- `P` - Paste before cursor/line
- `u` - Undo
- `Ctrl+r` - Redo
- `jk` - Exit insert mode (alternative to ESC)

#### Window Management
- `<Space>sv` - Split vertically
- `<Space>sh` - Split horizontally
- `<Space>sx` - Close split
- `Ctrl+h/j/k/l` - Navigate between splits

#### Display Issues
- If lines appear wrapped but shouldn't be: `:set nowrap`
- For markdown files that auto-wrap: `:setlocal nowrap`
- Navigate wrapped lines: use `gj`/`gk` instead of `j`/`k`