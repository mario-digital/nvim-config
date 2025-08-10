# Neovim Configuration

Modular Neovim configuration built on Lazy.nvim with focus on development productivity.

## Requirements

- Neovim >= 0.9.0
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope live grep
- [fd](https://github.com/sharkdp/fd) for better file finding performance
- C compiler for Treesitter parsers
- Node.js (optional, for additional language servers)

## Installation

```bash
# Backup existing configuration
mv ~/.config/nvim ~/.config/nvim.bak

# Clone repository
git clone https://github.com/mario-digital/nvim-config.git ~/.config/nvim

# Start Neovim - plugins will auto-install
nvim
```

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point, loads core and lazy modules
├── lazy-lock.json              # Plugin version lock file
└── lua/
    └── mario/
        ├── lazy.lua            # Lazy.nvim bootstrap and configuration
        ├── core/
        │   ├── init.lua        # Core module loader
        │   ├── options.lua     # Vim options (tabs, search, clipboard)
        │   └── keymaps.lua     # Base keymaps (leader: space)
        └── plugins/
            ├── alpha.lua       # Start screen
            ├── auto-session.lua # Session management
            ├── autopairs.lua   # Bracket/quote pairing
            ├── bufferline.lua  # Buffer visualization
            ├── colorscheme.lua # Tokyo Night theme
            ├── comment.lua     # Code commenting
            ├── dressing.lua    # UI enhancements
            ├── indent-blankline.lua # Indentation guides
            ├── init.lua        # Common dependencies
            ├── lualine.lua     # Status line
            ├── nvim-cmp.lua    # Completion engine
            ├── nvim-tree.lua   # File explorer
            ├── telescope.lua   # Fuzzy finder
            ├── todo-comments.lua # TODO highlighting
            ├── treesitter.lua  # Syntax highlighting
            ├── vim-maximizer.lua # Window maximization
            └── which-key.lua   # Keymap hints
```

## Key Bindings

Leader key: `<Space>`

### Navigation
- `<leader>ff` - Find files
- `<leader>fs` - Live grep
- `<leader>fr` - Recent files
- `<leader>fc` - Search word under cursor
- `<leader>ft` - Find TODOs

### File Explorer
- `<leader>ee` - Toggle explorer
- `<leader>ef` - Focus current file
- `<leader>ec` - Collapse directories
- `<leader>er` - Refresh explorer

### Window Management
- `<leader>sv` - Split vertical
- `<leader>sh` - Split horizontal
- `<leader>se` - Equal splits
- `<leader>sx` - Close split
- `<leader>sm` - Maximize/restore

### Tabs/Buffers
- `<leader>to` - New tab
- `<leader>tx` - Close tab
- `<leader>tn` - Next tab
- `<leader>tp` - Previous tab

### Session
- `<leader>wr` - Restore session
- `<leader>ws` - Save session

### Editing
- `jk` - Exit insert mode
- `<leader>nh` - Clear search highlights
- `<leader>+` - Increment number
- `<leader>-` - Decrement number
- `gcc` - Comment line
- `gc` - Comment selection (visual mode)

### LSP (when configured)
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<leader>ca` - Code actions

## Configuration Details

### Editor Settings
- Relative line numbers with absolute on cursor line
- 2-space indentation (expandtab)
- System clipboard integration
- Persistent undo
- No swap files
- Smart case search

### Plugin Highlights

**Telescope**: Extensible fuzzy finder with live grep, file browsing, and git integration. Configured with smart path display and fzf-native for performance.

**Treesitter**: Incremental parsing for accurate syntax highlighting and code understanding. Auto-installs parsers for common languages.

**nvim-cmp**: Completion framework with LSP, buffer, path, and snippet sources. Includes LuaSnip for snippet expansion.

**auto-session**: Workspace persistence. Automatically saves session state, excludes common directories (~/Downloads, ~/Desktop).

**Tokyo Night**: Custom color scheme with modified backgrounds for better contrast in terminal environments.

## Adding Language Servers

This configuration is LSP-ready but doesn't include specific language servers. To add LSP support:

1. Install language servers:
```bash
# Examples
npm install -g typescript-language-server
npm install -g pyright
brew install lua-language-server
```

2. Create `lua/mario/plugins/lsp/lspconfig.lua`:
```lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    
    -- Configure servers
    lspconfig.tsserver.setup({ capabilities = capabilities })
    lspconfig.pyright.setup({ capabilities = capabilities })
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    })
  end
}
```

## Plugin Management

```vim
:Lazy               " Open plugin manager
:Lazy update        " Update plugins
:Lazy sync          " Sync plugin state
:Lazy restore       " Restore from lock file
```

## Troubleshooting

### Health Check
```vim
:checkhealth
```

### Common Issues

**Telescope errors**: Install ripgrep and fd:
```bash
# macOS
brew install ripgrep fd

# Linux
sudo apt install ripgrep fd-find
```

**Treesitter compilation fails**: Ensure C compiler is installed:
```bash
# macOS
xcode-select --install

# Linux
sudo apt install build-essential
```

**Fonts**: For proper icon display, install a Nerd Font:
```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

## Performance

- Lazy loading configured for most plugins
- Treesitter uses incremental parsing
- Telescope uses fzf-native for C-speed sorting
- Auto-session excludes large directories
- Startup time: ~50-100ms on modern hardware

## License

MIT