# Custom NvChad Configuration

**This repo is supposed to be used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

## 🚀 Quick Installation

### Prerequisites

Before installing this configuration, ensure you have the following installed:

#### 1. Core Dependencies
```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core dependencies
brew install neovim git node python3 ripgrep fd lua-language-server

# Install Python support for Neovim
pip3 install pynvim
```

#### 2. Go Development Setup
```bash
# Install Go
brew install go

# Install Go language server and development tools
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest
```

#### 3. Additional Language Servers (Optional)
```bash
# TypeScript/JavaScript
npm install -g typescript-language-server @vtsls/language-server

# JSON/YAML
npm install -g vscode-langservers-extracted yaml-language-server

# Python
pip3 install python-lsp-server

# Formatters and Linters
npm install -g prettier eslint
pip3 install black isort flake8
```

### Installation Steps

1. **Backup existing Neovim configuration (if any):**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration:**
   ```bash
   git clone git@github.com:1000Roses/custom-nvimchad.git ~/.config/nvim
   cd ~/.config/nvim
   ```

3. **Start Neovim and let plugins install:**
   ```bash
   nvim
   ```
   
   The Lazy plugin manager will automatically install all plugins on first startup.

4. **Verify installation:**
   - Open Neovim
   - Run `:checkhealth` to verify all components are working
   - Run `:Lazy` to see plugin status
   - Run `:LspInfo` to check LSP servers

## ✨ Features

### Core Features
- **Plugin Manager:** Lazy.nvim for fast plugin loading
- **LSP Support:** Full Language Server Protocol integration
- **File Explorer:** Neo-tree for file management
- **Fuzzy Finder:** Telescope for file and text searching
- **Terminal:** Toggleterm for integrated terminal support
- **Diagnostics:** Trouble.nvim for error management
- **Syntax Highlighting:** Treesitter for advanced syntax highlighting
- **Auto-completion:** nvim-cmp with multiple sources
- **Git Integration:** Gitsigns for git status in editor
- **Code Formatting:** Conform.nvim with multiple formatters

### Go Development
- **Language Server:** gopls integration with custom configuration
- **Debugging:** Delve debugger support
- **Testing:** Integrated Go test runner
- **Formatting:** gofumpt and goimports integration
- **Import Management:** Automatic import organization

## ⌨️ Key Bindings

### Terminal Management
- `<leader>tf` - Toggle floating terminal
- `<leader>th` - Toggle horizontal terminal
- `<leader>tv` - Toggle vertical terminal
- `<leader>dr` - Split terminal horizontally
- `<Ctrl+t>` - Toggle floating terminal
- `<Ctrl+\>` - Toggle floating terminal

### Diagnostics & Errors
- `<leader>xx` - Show project diagnostics
- `<leader>xX` - Show buffer diagnostics

### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - Toggle file explorer

### LSP Features
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show hover information
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

*Note: `<leader>` is mapped to the Space key*

## 🛠️ Troubleshooting

### Plugin Issues
If plugins don't install properly:
```bash
nvim --headless -c 'lua require("lazy").sync()' -c 'qa'
```

### LSP Issues
If Language Server Protocol doesn't work:
- Check `:LspInfo` for server status
- Ensure language servers are in PATH
- Run `:checkhealth lsp` for diagnostics

### Go Tools Issues
If Go development tools don't work:
- Ensure `$GOPATH/bin` is in your PATH
- Verify Go installation: `go version`
- Check gopls: `gopls version`

### Duplicate Error Messages
If you see duplicate errors in Trouble.nvim:
- Restart Neovim after configuration changes
- Check that only one LSP server is running for Go files
- Run `:LspInfo` to verify LSP client status

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration entry point
├── lua/
│   ├── autocmds.lua        # Auto commands
│   ├── chadrc.lua          # NvChad configuration
│   ├── mappings.lua        # Key mappings
│   ├── options.lua         # Neovim options
│   ├── configs/
│   │   ├── conform.lua     # Code formatting configuration
│   │   ├── lazy.lua        # Plugin manager setup
│   │   └── lspconfig.lua   # LSP server configurations
│   └── plugins/
│       └── init.lua        # Plugin specifications
└── lazy-lock.json          # Plugin version lock file
```

## 🔧 Customization

### Adding New Plugins
Add plugins to `lua/plugins/init.lua`:
```lua
{
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Modifying Key Bindings
Edit `lua/mappings.lua` to customize key mappings.

### LSP Configuration
Modify `lua/configs/lspconfig.lua` to add or configure language servers.

### Formatting Rules
Update `lua/configs/conform.lua` to change code formatting behavior.

## 📋 System Requirements

- **Neovim:** ≥ 0.9.0
- **Git:** For plugin management
- **Node.js:** For LSP servers and some plugins
- **Python 3:** For Python support and some plugins
- **Go:** For Go development features
- **Ripgrep:** For fast text searching
- **fd:** For fast file finding

## 🤝 Contributing

Feel free to submit issues and pull requests to improve this configuration!

## Credits

1) **NvChad:** https://github.com/NvChad/NvChad - The amazing Neovim configuration framework
2) **Lazyvim starter:** https://github.com/LazyVim/starter - Inspiration for the starter structure
