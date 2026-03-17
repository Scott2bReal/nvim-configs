# AGENTS.md — Neovim Config

Personal Neovim configuration managed as a git repo. Plugin manager is **lazy.nvim**. All Lua, no Vimscript beyond compatibility shims.

---

## Repository Layout

```
~/.config/nvim/
├── init.lua                   # Entry point; loads config/ unless running in VSCode
├── lazy-lock.json             # Lockfile — commit when adding/updating plugins
├── lua/
│   ├── config/
│   │   ├── init.lua           # Requires the four config modules in order
│   │   ├── options.lua        # vim.opt settings
│   │   ├── keymaps.lua        # Global keymaps (leader = <Space>)
│   │   ├── autocommands.lua   # FileType / event autocmds
│   │   └── lazy.lua           # Bootstrap + lazy.nvim setup
│   └── plugins/
│       ├── core.lua           # Lazy self-manages
│       ├── lsp/
│       │   ├── init.lua       # Mason, mason-lspconfig, conform, LSP wiring
│       │   ├── handlers.lua   # on_attach, capabilities, diagnostics config
│       │   └── settings/      # Per-server opts (lua_ls.lua, biome.lua, etc.)
│       └── *.lua              # One file per plugin or plugin group
└── spell/                     # Custom spell files
```

---

## Plugin Management

- **lazy.nvim** auto-bootstraps on first run via `lua/config/lazy.lua`
- Plugins are discovered by `import = "plugins"` — every `.lua` in `lua/plugins/` is loaded
- Adding a plugin: create or edit a file in `lua/plugins/` returning a lazy spec table
- Updating plugins: `:Lazy update` or `<leader>pu`; commit `lazy-lock.json` afterward
- Syncing (install missing + remove unused): `:Lazy sync` or `<leader>ps`
- Default colorscheme: `gruvbox-material` (installed eagerly, `priority = 1000`)

---

## LSP & Formatting

### Servers managed by Mason
`astro`, `biome`, `bashls`, `jsonls`, `lua_ls`, `html`, `eslint`, `yamlls`, `tailwindcss`, `prismals`

Adding a new server: add the string to the `servers` table in `lua/plugins/lsp/init.lua`, then optionally add `lua/plugins/lsp/settings/<server>.lua` returning extra opts.

### Formatting (conform.nvim)
- Lua → `stylua`
- JS/TS/JSON → `biome` → `prettierd` → `prettier` (first found, `stop_after_first = true`)
- Format current buffer: `<leader>lf`
- Runs automatically on `BufWritePre`

### Formatting disabled on LSP side
`tsserver`/`ts_ls`, `jsonls`, and `astro` have `document_formatting = false` in `on_attach` — conform owns formatting for those types.

### Biome LSP
Only activates when a `biome.json` / `biome.jsonc` is present in the project root (`single_file_support = false`).

### Completion (blink.cmp)
Source priority order: `lazydev` (score_offset 100) → `lsp` → `path` → `snippets` → `buffer`

Build step: `cargo build --release` — requires Rust toolchain.

---

## Code Conventions

- **Indentation**: 2 spaces (tabs expanded, `shiftwidth = 2`, `tabstop = 2`)
- **Plugin files**: each returns a lazy spec table (or list of tables)
- **Error handling pattern**: `pcall` + `vim.notify` on failure, then `return`
  ```lua
  local ok, mod = pcall(require, "some.module")
  if not ok then
    vim.notify("some.module couldn't load")
    return
  end
  ```
- **Keymap options**: always pass `{ noremap = true, silent = true }`
- **Autocommands**: always create a named augroup with `{ clear = true }` to avoid duplicate registrations
- **Type annotations**: use EmmyLua (`---@type`, `---@module`) where helpful — `lazydev.nvim` provides completions for lazy specs and blink types

---

## Key Bindings Reference

**Leader** = `<Space>`

| Key | Action |
|-----|--------|
| `<leader>e` | MiniFiles explorer |
| `<leader>f` | Telescope find files |
| `<leader>F` | Telescope live grep (ivy theme) |
| `<C-t>` | Telescope live grep |
| `<leader>b` | Telescope buffers (dropdown) |
| `<leader>c` | Close buffer (MiniBufremove) |
| `<leader>/` | Comment current line (mini.comment) |
| `<leader>h` | Clear search highlight |
| `<leader>lf` | Format (conform) |
| `<leader>lR` | Restart LSP |
| `<leader>lI` | Open Mason UI |
| `<leader>lt*` | TypeScript Tools (add imports, organize, fix all, rename) |
| `<leader>g*` | Git (gitsigns hunks, blame, diff, Telescope git views) |
| `<leader>p*` | Lazy plugin management |
| `<leader>s*` | Search (oldfiles, help, keymaps, diagnostics, colorschemes) |
| `<leader>zr` | Reload Neovim config (`:source $MYVIMRC`) |
| `<leader>zz` | Toggle GitHub Copilot |
| `<leader>zd` | Toggle MiniDiff overlay |
| `<leader>nh` | MiniNotify history |
| `jj` (insert) | Escape to normal |
| `<S-l>` / `<S-h>` | Next/previous buffer |
| `<C-h/j/k/l>` | Window navigation |

**LSP buffer keys** (set in `on_attach`):

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `K` | Hover |
| `<C-k>` | Signature help |
| `[d` / `]d` | Prev/next diagnostic |
| `gl` | Open diagnostic float |
| `<leader>q` | Diagnostics → loclist |

**Completion (blink.cmp)**:

| Key | Action |
|-----|--------|
| `<C-j>` / `<Tab>` | Select next |
| `<C-k>` / `<S-Tab>` | Select prev |
| `<CR>` | Accept |

---

## Plugins Quick Reference

| Plugin | Purpose |
|--------|---------|
| `lazy.nvim` | Plugin manager |
| `gruvbox-material` | Default colorscheme (also gruvbox, kanagawa, catppuccin available) |
| `nvim-lspconfig` + `mason` | LSP servers |
| `typescript-tools.nvim` | Enhanced TS/JS LSP (`:TSTools*` commands) |
| `conform.nvim` | Formatting on save |
| `blink.cmp` | Completion (requires Rust) |
| `nvim-treesitter` | Syntax / indent (`:TSUpdate` build step) |
| `nvim-treesitter-context` | Sticky context header |
| `telescope.nvim` | Fuzzy finder |
| `mini.nvim` | Files, tabline, bufremove, comment, notify, diff, pairs, icons, pick |
| `which-key.nvim` | Keybinding help popup |
| `gitsigns.nvim` | Git hunk signs + actions |
| `lualine.nvim` | Status line |
| `alpha-nvim` | Dashboard on startup |
| `copilot.lua` | GitHub Copilot (`<C-f>` accept, `<C-]>` dismiss) |
| `render-markdown.nvim` | Rendered markdown display (markdown ft only) |
| `vimwiki` + `vimwiki-sync` | Personal wiki at `~/vimwiki` (markdown syntax, `.md` ext) |
| `lazydev.nvim` | Neovim Lua type completions (lua ft only) |
| `rainbow-delimiters` | Rainbow bracket coloring |
| `indent-blankline` | Indent guides |
| `colorizer` | Inline color preview |
| `surround` (mini or separate) | Text surrounds |
| `tidy` | Whitespace cleanup |
| `ts-autotags` | Auto close/rename HTML tags |

---

## Autocommands

| Event | Filetype/Pattern | Effect |
|-------|-----------------|--------|
| `FileType` | `gitcommit` | `wrap = true`, `spell = true` |
| `FileType` | `markdown` | `spell = true`, treesitter highlight |
| `BufRead/BufEnter` | `*.astro` | Force `filetype = astro` |
| `VimResized` | `*` | `tabdo wincmd =` (equalize splits) |
| `User AlphaReady` | — | Hide tabline on dashboard |
| `VimLeave` | — | Reset cursor to horizontal bar |

---

## Gotchas

- **VSCode guard**: `init.lua` skips loading config when `vim.g.vscode` is set — keep that check intact.
- **treesitter.lua uses tabs** while most files use 2-space indent — don't reformat it without checking the actual file.
- **lazy-lock.json**: treat it like a lockfile. Commit changes when plugins are intentionally updated.
- **`netrwPlugin` is disabled** in lazy's `disabled_plugins` — use `MiniFiles` (`<leader>e`) for file browsing, not netrw/`:Lex`.
- **Formatting ownership**: LSP formatting is disabled for `ts_ls`, `jsonls`, and `astro`; always goes through conform. Don't re-enable it on the LSP side.
- **Biome only loads with config file**: `single_file_support = false` means biome LSP won't start in projects without `biome.json`.
- **blink.cmp needs Rust**: the `build = "cargo build --release"` step requires a Rust toolchain; without it completions won't work.
- **MiniTabline `add_modified_icon`** references the global `MiniTabline` (set up by mini.nvim) — it must be loaded before calling.
- **Fold method is `marker`** (`{{{` / `}}}`), not treesitter or LSP folds.
