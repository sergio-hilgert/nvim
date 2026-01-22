# NvChad Custom Configuration

A powerful, feature-rich Neovim configuration built on top of [NvChad](https://nvchad.com/). This setup is optimized for **Ruby on Rails development with Docker**, but works great for any programming language.

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

## Table of Contents

- [What is Neovim?](#what-is-neovim)
- [What is NvChad?](#what-is-nvchad)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Automatic Installation](#automatic-installation)
  - [Manual Installation](#manual-installation)
- [Post-Installation](#post-installation)
- [Understanding Vim/Neovim Basics](#understanding-vimneovim-basics)
- [Keybindings Reference](#keybindings-reference)
  - [Essential NvChad Keybindings](#essential-nvchad-keybindings)
  - [File Navigation](#file-navigation)
  - [Git Integration](#git-integration)
  - [Terminal](#terminal)
  - [Ruby/Rails Development](#rubyrails-development)
  - [LSP (Language Server Protocol)](#lsp-language-server-protocol)
  - [Snacks Plugin](#snacks-plugin)
  - [Avante AI Assistant](#avante-ai-assistant)
  - [Completion](#completion)
- [Plugin Overview](#plugin-overview)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)

---

## What is Neovim?

[Neovim](https://neovim.io/) is a hyperextensible text editor based on Vim. It's designed for efficient text editing and is highly customizable through Lua scripting. Key features include:

- **Modal Editing**: Different modes for different tasks (Normal, Insert, Visual, Command)
- **Extensibility**: Thousands of plugins available
- **Performance**: Fast and lightweight
- **LSP Support**: Built-in Language Server Protocol support for IDE-like features
- **Terminal Integration**: Built-in terminal emulator

## What is NvChad?

[NvChad](https://nvchad.com/) is a Neovim configuration framework that provides:

- Beautiful UI with 68+ themes
- Lazy-loaded plugins for fast startup
- Pre-configured LSP, completion, and syntax highlighting
- Easy customization through a simple configuration structure

---

## Prerequisites

Before installing, ensure you have:

| Requirement | Version | Purpose |
|-------------|---------|---------|
| Neovim | 0.11+ | The editor itself |
| Git | Any | Plugin management |
| Nerd Font | Any | Icons and symbols |
| Node.js | 18+ | Some LSP servers |
| Ripgrep | Any | Fast file searching |
| GCC/Clang | Any | Treesitter compilation |
| tree-sitter-cli | Any | Parser installation |

### Optional (for full features):

| Tool | Purpose |
|------|---------|
| lazygit | Git TUI integration |
| lazydocker | Docker TUI integration |
| Docker | Ruby/Rails development |
| gh (GitHub CLI) | GitHub integration |

---

## Installation
### Manual Installation

#### Step 1: Install Neovim

**macOS:**
```bash
brew install neovim
```

**Ubuntu/Debian:**
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

**Fedora:**
```bash
sudo dnf install neovim
```

**Arch Linux:**
```bash
sudo pacman -S neovim
```

#### Step 2: Install Dependencies

**macOS:**
```bash
brew install git ripgrep fd lazygit node npm gcc make tree-sitter
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

**Ubuntu/Debian:**
```bash
sudo apt install git ripgrep fd-find nodejs npm gcc make curl
sudo npm install -g tree-sitter-cli
```

#### Step 3: Backup Existing Config (if any)

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

#### Step 4: Clone This Configuration

```bash
git clone https://github.com/sergio-hilgert/nvim-config.git ~/.config/nvim
```

#### Step 5: Start Neovim

```bash
nvim
```

Wait for plugins to install automatically.

---

## Post-Installation

After installation, run these commands inside Neovim:

1. **Install LSP servers:**
   ```
   :MasonInstallAll
   ```

2. **Install Treesitter parsers:**
   ```
   :TSInstallAll
   ```

3. **Check health:**
   ```
   :checkhealth
   ```

---

## Understanding Vim/Neovim Basics

### Modes

Neovim has different modes for different tasks:

| Mode | Key to Enter | Purpose |
|------|--------------|---------|
| **Normal** | `Esc` or `jj` | Navigation and commands |
| **Insert** | `i`, `a`, `o` | Typing text |
| **Visual** | `v`, `V`, `Ctrl+v` | Selecting text |
| **Command** | `:` or `;` | Running commands |

### Essential Movements

| Key | Action |
|-----|--------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `w` | Next word |
| `b` | Previous word |
| `gg` | Go to top of file |
| `G` | Go to bottom of file |
| `0` | Go to start of line |
| `$` | Go to end of line |

### Basic Operations

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | New line below |
| `O` | New line above |
| `dd` | Delete line |
| `yy` | Copy (yank) line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `Ctrl+r` | Redo |

---

## Keybindings Reference

> **Note:** `<leader>` is the **Space** key in this configuration.

### Essential NvChad Keybindings

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ch` | Normal | Open cheatsheet (shows all keybindings) |
| `<leader>te` | Normal | Theme picker (change colorscheme) |
| `;` | Normal | Enter command mode (same as `:`) |
| `jj` | Insert | Exit insert mode (same as `Esc`) |

### File Navigation

#### Telescope (Fuzzy Finder)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ff` | Normal | Find files |
| `<leader>fw` | Normal | Find word (grep) |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Find help tags |
| `<leader>fo` | Normal | Find old/recent files |
| `<leader>fz` | Normal | Find in current buffer |
| `<leader>cm` | Normal | Git commits |
| `<leader>gt` | Normal | Git status |
| `<leader>ma` | Normal | Find marks |

#### NvimTree (File Explorer)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Ctrl>n` | Normal | Toggle file tree |
| `<leader>e` | Normal | Focus file tree |
| `Enter` | Tree | Open file/folder |
| `a` | Tree | Create new file |
| `d` | Tree | Delete file |
| `r` | Tree | Rename file |
| `c` | Tree | Copy file |
| `p` | Tree | Paste file |
| `y` | Tree | Copy filename |
| `Y` | Tree | Copy relative path |

#### Buffers & Tabs

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Tab>` | Normal | Next buffer |
| `<Shift>Tab` | Normal | Previous buffer |
| `<leader>x` | Normal | Close buffer |
| `<leader>b` | Normal | New buffer |

### Git Integration

#### LazyGit (via Snacks)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>gg` | Normal | Open LazyGit |
| `<leader>gL` | Normal | LazyGit log |
| `<leader>gF` | Normal | LazyGit log (current file) |

#### GitBrowse (Open in Browser)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>gR` | Normal | Open repo in browser |
| `<leader>gB` | Normal | Open branch in browser |
| `<leader>gO` | Normal/Visual | Open file/lines in browser |
| `<leader>gU` | Normal/Visual | Open permalink URL |
| `<leader>gC` | Normal | Open commit in browser |

#### GitHub Integration (requires `gh` CLI)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>gi` | Normal | GitHub issues (open) |
| `<leader>gI` | Normal | GitHub issues (all) |
| `<leader>gp` | Normal | GitHub PRs (open) |
| `<leader>gP` | Normal | GitHub PRs (all) |

#### Gitsigns (Git Hunks)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `]c` | Normal | Next git hunk |
| `[c` | Normal | Previous git hunk |
| `<leader>rh` | Normal | Reset hunk |
| `<leader>ph` | Normal | Preview hunk |
| `<leader>gb` | Normal | Git blame line |
| `<leader>td` | Normal | Toggle deleted |

### Terminal

#### ToggleTerm

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Ctrl>\` | Normal/Terminal | Toggle terminal |
| `<leader>tf` | Normal | Terminal float |
| `<leader>th` | Normal | Terminal horizontal |
| `<leader>tv` | Normal | Terminal vertical |
| `<leader>tt` | Normal | Terminal in new tab |
| `<leader>ta` | Normal | Toggle all terminals |
| `<leader>t1` | Normal | Toggle terminal #1 |
| `<leader>t2` | Normal | Toggle terminal #2 |
| `<leader>t3` | Normal | Toggle terminal #3 |
| `<leader>ts` | Normal | Send current line to terminal |
| `<leader>ts` | Visual | Send selection to terminal |
| `<Esc>` | Terminal | Exit terminal mode |
| `<Ctrl>h/j/k/l` | Terminal | Navigate to other windows |

#### LazyDocker

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>td` | Normal | Open LazyDocker |

### Ruby/Rails Development

> **Note:** These commands run inside Docker containers. Set `PROJECT_NAME` env var or let it auto-detect from folder name.

#### RSpec Testing

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>rsa` | Normal | Run RSpec for current file |
| `<leader>rsi` | Normal | Run RSpec for current line |
| `<leader>rsp` | Normal | Run RSpec in parallel |
| `<leader>rsc` | Normal | Run RSpec for current directory (in nvim-tree) |

#### Code Quality

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>rba` | Normal | Run Rubocop with autofix |
| `<leader>rbu` | Normal | Run Undercover (test coverage) |

#### Database

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>rdb` | Normal | Clear & rebuild database |
| `<leader>rdm` | Normal | Run database migrations |
| `<leader>rdc` | Normal | Create new migration |
| `<leader>rdp` | Normal | Open PostgreSQL console |

#### Docker

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>rh` | Normal | Open container shell (zsh) |

### LSP (Language Server Protocol)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Go to references |
| `K` | Normal | Hover documentation |
| `<leader>ca` | Normal | Code actions |
| `<leader>ra` | Normal | Rename symbol |
| `<leader>D` | Normal | Type definition |
| `<leader>ds` | Normal | Document symbols |
| `<leader>ws` | Normal | Workspace symbols |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `<leader>q` | Normal | Diagnostic list |
| `<leader>fm` | Normal | Format file |

### Snacks Plugin

#### Scratch Buffers

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>.` | Normal | Toggle scratch buffer |
| `<leader>S` | Normal | Select scratch buffer |

#### Notifications

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>nh` | Normal | Notification history |
| `<leader>nd` | Normal | Dismiss all notifications |
| `<leader>nt` | Normal | Test notification |

#### LSP References (Words)

| Keybinding | Mode | Description |
|------------|------|-------------|
| `]r` | Normal | Next reference |
| `[r` | Normal | Previous reference |

### Avante AI Assistant

Avante provides AI-powered coding assistance using Claude or OpenAI.


| Keybinding | Description |
|------------|-------------|
| `<leader>aa` | Show/open Avante sidebar |
| `<leader>at` | Toggle Avante sidebar visibility |
| `<leader>ar` | Refresh Avante sidebar |
| `<leader>af` | Switch Avante sidebar focus |
| `<leader>ae` | Edit selected blocks |
| `<leader>an` | New ask (start new conversation) |
| `<leader>aS` | Stop current AI request |
| `<leader>ah` | Select between chat histories |
| `<leader>a?` | Select model |
| `<leader>ad` | Toggle debug mode |
| `<leader>as` | Toggle suggestion display |
| `<leader>aR` | Toggle repomap |
| `<leader>ac` | Add current buffer to selected files |
| `<leader>aB` | Add all buffer files to selected files |


### Window Management

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Ctrl>h` | Normal | Move to left window |
| `<Ctrl>j` | Normal | Move to bottom window |
| `<Ctrl>k` | Normal | Move to top window |
| `<Ctrl>l` | Normal | Move to right window |
| `<leader>sv` | Normal | Split vertical |
| `<leader>sh` | Normal | Split horizontal |

### Completion

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>cp` | Normal/Insert | Toggle autocomplete on/off |

### Comments

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>/` | Normal | Toggle comment |
| `<leader>/` | Visual | Toggle comment (selection) |
| `gcc` | Normal | Toggle line comment |
| `gbc` | Normal | Toggle block comment |

---

## Plugin Overview

| Plugin | Purpose |
|--------|---------|
| **NvChad** | Base configuration framework |
| **lazy.nvim** | Plugin manager |
| **nvim-treesitter** | Syntax highlighting |
| **nvim-lspconfig** | LSP configuration |
| **mason.nvim** | LSP/DAP/Linter installer |
| **nvim-cmp** | Autocompletion |
| **telescope.nvim** | Fuzzy finder |
| **nvim-tree** | File explorer |
| **gitsigns.nvim** | Git integration |
| **toggleterm.nvim** | Terminal integration |
| **snacks.nvim** | Utilities (lazygit, notifications, etc.) |
| **avante.nvim** | AI assistant |
| **vim-ruby** | Ruby support |
| **vim-rails** | Rails support |
| **conform.nvim** | Code formatting |
| **nvim-lint** | Linting |

---

## Customization

### Changing Theme

Press `<leader>te` to open the theme picker, or add to `lua/chadrc.lua`:

```lua
M.base46 = {
  theme = "onedark", -- or any of 68+ themes
}
```

### Adding Plugins

Create a new file in `lua/plugins/`:

```lua
-- lua/plugins/myplugin.lua
return {
  "author/plugin-name",
  event = "VeryLazy",
  config = function()
    require("plugin-name").setup({})
  end,
}
```

### Adding Keybindings

Edit `lua/mappings.lua`:

```lua
local map = vim.keymap.set

map("n", "<leader>xx", function()
  -- your function here
end, { desc = "Description" })
```

---

## Troubleshooting

### Plugins not loading

```vim
:Lazy sync
```

### LSP not working

```vim
:LspInfo
:Mason
```

### Icons not showing

Make sure you're using a Nerd Font in your terminal.

### Treesitter errors

```vim
:TSUpdate
```
