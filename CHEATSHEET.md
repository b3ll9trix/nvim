# Neovim Keybinding Cheatsheet

**Leader key: `Space`**

---

## General

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>W` | Save all files |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all |
| `<Esc>` | Clear search highlight |

---

## Navigation (Windows/Buffers)

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<C-Up/Down>` | Resize window height |
| `<C-Left/Right>` | Resize window width |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>sc` | Close split |
| `<leader>se` | Equalize splits |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bD` | Delete other buffers |

---

## LSP (Code Intelligence)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>ds` | Show diagnostics |
| `<leader>dl` | Diagnostics to loclist |
| `[d` / `]d` | Prev/Next diagnostic |
| `<leader>ws` | Workspace symbols |
| `<leader>ih` | Toggle inlay hints |
| `<leader>fm` | Format file |

---

## Telescope (Fuzzy Finder)

### Files
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Grep word under cursor |
| `<leader>fb` | Buffers |

### Search
| Key | Action |
|-----|--------|
| `<leader>fs` | Search in buffer |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>fc` | Commands |

### LSP
| Key | Action |
|-----|--------|
| `<leader>fd` | Diagnostics |
| `<leader>fo` | Document symbols |
| `<leader>fO` | Workspace symbols |

### Git
| Key | Action |
|-----|--------|
| `<leader>fgc` | Git commits |
| `<leader>fgb` | Git branches |
| `<leader>fgs` | Git status |

### Other
| Key | Action |
|-----|--------|
| `<leader>f.` | Resume last search |

### Inside Telescope
| Key | Action |
|-----|--------|
| `<C-j/k>` | Move selection |
| `<C-q>` | Send to quickfix |
| `<Esc>` | Close |

---

## File Tree (nvim-tree)

| Key | Action |
|-----|--------|
| `<leader>n` | Toggle file tree |
| `<leader>e` | Focus file tree |
| `<leader>nf` | Find current file |

---

## Harpoon (Quick Files)

| Key | Action |
|-----|--------|
| `<leader>ha` | Add file to harpoon |
| `<leader>hh` | Harpoon menu |
| `<leader>h1` | Jump to file 1 |
| `<leader>h2` | Jump to file 2 |
| `<leader>h3` | Jump to file 3 |
| `<leader>h4` | Jump to file 4 |
| `<leader>hp` | Previous harpoon file |
| `<leader>hn` | Next harpoon file |

---

## Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue/Start |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression |

---

## Testing (neotest)

| Key | Action |
|-----|--------|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Stop test |
| `<leader>tw` | Toggle watch mode |
| `<leader>td` | Debug nearest test |
| `[T` / `]T` | Prev/Next failed test |

---

## Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |

### Inside Terminal
| Key | Action |
|-----|--------|
| `<Esc>` | Exit terminal mode |
| `<C-h/j/k/l>` | Navigate to window |

---

## Trouble (Diagnostics Panel)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Document symbols |
| `<leader>xl` | LSP definitions/refs |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `[t` / `]t` | Prev/Next trouble item |

---

## Git

| Key | Action |
|-----|--------|
| `<leader>gd` | Open Diffview |

---

## Go-specific (gopher.nvim)

| Key | Action |
|-----|--------|
| `<leader>gsj` | Add json struct tags |
| `<leader>gsy` | Add yaml struct tags |
| `<leader>gsr` | Remove json tags |
| `<leader>gie` | Add `if err` block |
| `<leader>gim` | Implement interface |
| `<leader>gtg` | Generate all tests |

---

## Rust - Cargo.toml (crates.nvim)

| Key | Action |
|-----|--------|
| `<leader>ct` | Toggle crates info |
| `<leader>cr` | Reload crates |
| `<leader>cv` | Show versions |
| `<leader>cf` | Show features |
| `<leader>cd` | Show dependencies |
| `<leader>cu` | Update crate |
| `<leader>cU` | Upgrade crate |
| `<leader>cA` | Upgrade all crates |

---

## Editing

| Key | Action |
|-----|--------|
| `gcc` | Comment line |
| `gc` (visual) | Comment selection |
| `<A-j>` / `<A-k>` | Move line up/down |
| `J` / `K` (visual) | Move selection up/down |
| `<` / `>` (visual) | Indent (stay in visual) |
| `<C-d>` / `<C-u>` | Half page down/up (centered) |
| `n` / `N` | Next/Prev search (centered) |

### Treesitter Text Objects
| Key | Action |
|-----|--------|
| `af` | Around function |
| `if` | Inner function |
| `ac` | Around class |
| `ic` | Inner class |

### Surround (vim-surround)
| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |

---

## Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<Tab>` | Next item / expand snippet |
| `<S-Tab>` | Previous item / jump back |
| `<CR>` | Confirm selection |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort completion |
| `<C-b>` / `<C-f>` | Scroll docs up/down |

---

## Quickfix

| Key | Action |
|-----|--------|
| `<leader>co` | Open quickfix |
| `<leader>cc` | Close quickfix |
| `[q` / `]q` | Prev/Next quickfix item |

---

## Markdown

| Key | Action |
|-----|--------|
| `<leader>mp` | Toggle markdown preview |

---

## Useful Commands

| Command | Action |
|---------|--------|
| `:Lazy` | Plugin manager |
| `:Lazy sync` | Update plugins |
| `:Mason` | LSP/Tool installer |
| `:LspInfo` | LSP status |
| `:ConformInfo` | Formatter info |
| `:checkhealth` | Diagnostics |
| `:Telescope` | All telescope pickers |

---

## First Time Setup

1. Open Neovim
2. Run `:Lazy sync` to install plugins
3. Run `:Mason` to install language servers:
   - `gopls` (Go)
   - `rust-analyzer` (Rust - auto via rustaceanvim)
   - `lua_ls` (Lua)
4. Install formatters via Mason:
   - `goimports`, `gofumpt` (Go)
   - `stylua` (Lua)
   - `codelldb` (Rust debugging)
   - `delve` (Go debugging)
