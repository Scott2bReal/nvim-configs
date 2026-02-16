# AGENTS.md - Neovim Configuration Guide

This is a comprehensive Neovim configuration built with Lazy.nvim package manager. This guide helps AI agents understand how to work effectively in this codebase.

## Project Structure

```
~/.config/nvim/
├── init.lua                   # Main entry point
├── lazy-lock.json            # Plugin version lock file
├── lua/
│   ├── .luarc.json          # Lua LSP configuration
│   ├── config/              # Core configuration modules
│   │   ├── init.lua         # Config loader
│   │   ├── options.lua      # Neovim options/settings
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Lazy.nvim setup
│   │   └── autocommands.lua # Auto commands
│   └── plugins/             # Plugin configurations
│       ├── core.lua         # Core dependencies
│       ├── lsp/             # LSP configurations
│       │   ├── init.lua     # Main LSP setup
│       │   ├── handlers.lua # LSP handlers
│       │   └── settings/    # Language-specific settings
│       └── [individual plugin configs]
└── spell/                   # Spell check files
```

## Core Architecture

### Entry Point
- `init.lua`: Main entry point with VSCode compatibility check
- Loads `config` module which orchestrates everything

### Configuration Loading Order
1. `config/options.lua` - Neovim settings
2. `config/keymaps.lua` - Key mappings  
3. `config/lazy.lua` - Plugin manager setup
4. `config/autocommands.lua` - Auto commands

### Plugin System
- Uses **Lazy.nvim** as package manager
- Plugins defined in `lua/plugins/` directory
- Each plugin file returns a table/array of plugin specs
- Lazy loading extensively used with `event`, `cmd`, `ft` triggers

## Key Conventions

### Lua Coding Style
- **Indentation**: 2 spaces (not tabs)
- **Quotes**: Double quotes preferred
- **Tables**: Trailing commas used
- **Error Handling**: `pcall` used for safe require statements
- **Notifications**: `vim.notify()` for user messages

### Plugin Configuration Pattern
```lua
return {
  {
    "plugin/name",
    event = "BufRead", -- or cmd, ft, keys, etc.
    dependencies = { "dep1", "dep2" },
    opts = function()
      -- configuration logic
      return config_table
    end,
    config = function(_, opts)
      -- setup logic
    end,
  },
}
```

### Error Handling Pattern
```lua
local status_ok, module = pcall(require, "module_name")
if not status_ok then
  vim.notify("Module couldn't load")
  return
end
```

## Key Settings

### Editor Settings (options.lua)
- **Indentation**: 2 spaces, tabs converted to spaces
- **Line numbers**: Both absolute and relative enabled
- **Clipboard**: System clipboard integration (`unnamedplus`)
- **Search**: Case-insensitive with smart case
- **Splits**: Open below/right by default
- **Backup/Swap**: Disabled, persistent undo enabled
- **Scrolling**: 8 lines offset from edges

### Key Mappings (keymaps.lua)
- **Leader Key**: Space (`<Space>`)
- **Window Navigation**: `Ctrl+hjkl`
- **Buffer Navigation**: `Shift+hl`
- **File Explorer**: `<leader>e`
- **Window Resizing**: `Ctrl+arrow keys`

## Plugin Categories

### Core Dependencies
- `plenary.nvim` - Lua utility functions
- `nvim-web-devicons` - File icons
- `nui.nvim` - UI components
- `mini.icons` - Additional icons

### LSP & Completion
- **LSP**: `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim`
- **Formatting**: `none-ls.nvim` (null-ls successor)
- **Completion**: `nvim-cmp` with multiple sources
- **Snippets**: `LuaSnip`

### UI & Navigation
- **File Explorer**: `neo-tree.nvim`
- **Fuzzy Finder**: `telescope.nvim`
- **Statusline**: `lualine.nvim`
- **Bufferline**: `bufferline.nvim`
- **Dashboard**: `alpha-nvim`
- **Notifications**: `noice.nvim`

### Development Tools
- **Git**: `gitsigns.nvim`
- **Commenting**: `Comment.nvim`
- **Surround**: `nvim-surround`
- **Auto Pairs**: `nvim-autopairs`
- **Treesitter**: `nvim-treesitter`

### Language Support
- **TypeScript**: `typescript-tools.nvim`
- **Rust**: `rust-tools.nvim`
- **Markdown**: `render-markdown.nvim`, `markdown-preview.nvim`
- **Various LSPs**: Configured in `plugins/lsp/settings/`

## Language Server Configuration

### Supported Languages
- **TypeScript/JavaScript**: ESLint integration, Biome formatting and LSP
- **Lua**: Stylua formatting, nvim API completion
- **Python**: Pyright LSP
- **Rust**: Rust-analyzer via rust-tools
- **C/C++**: Clangd
- **JSON**: JSON LSP
- **Astro**: Astro LSP
- **Tailwind**: TailwindCSS LSP

### Biome LSP Configuration
- **Filetypes**: javascript, javascriptreact, typescript, typescriptreact, json, jsonc
- **Root Detection**: biome.json or biome.jsonc in project root
- **Single File Support**: Disabled (requires biome.json configuration)
- **Auto-attach**: Only when biome.json is present in project

### Formatting Tools (via none-ls)
- **Biome**: JavaScript/TypeScript/JSON
- **Stylua**: Lua
- **SQLFluff**: SQL (PostgreSQL dialect)
- **shfmt**: Shell scripts

## Development Workflow

### Adding New Plugins
1. Create new file in `lua/plugins/` or add to existing file
2. Follow the plugin spec pattern with lazy loading
3. Test the configuration
4. Update lazy-lock.json will be updated automatically

### Modifying LSP Settings
1. Language-specific settings in `lua/plugins/lsp/settings/`
2. General LSP setup in `lua/plugins/lsp/init.lua`
3. Formatters configured in none-ls setup

### Key Binding Changes
- Modify `lua/config/keymaps.lua` for global mappings
- Plugin-specific mappings usually in plugin config files

## Important Gotchas

### Plugin Loading
- Many plugins use lazy loading - check `event`, `cmd`, `ft` triggers
- Some functionality only available after triggering events
- Use `:Lazy` command to check plugin status

### LSP Setup
- Mason installs LSP servers automatically
- Language servers configured in `settings/` directory
- Some languages (like Rust) use specialized tools

### File Paths
- Configuration uses absolute paths starting from `~/.config/nvim/`
- Lua modules use dot notation (`config.options`)

### Custom Settings
- VimWiki configured for Markdown syntax
- Gruvbox Material colorscheme with "original" palette  
- Treesitter context commentstring integration
- C files (.h) treated as C syntax by default

### VSCode Compatibility
- Main init.lua includes VSCode check
- Only loads full config when not in VSCode

## Common Commands

### Plugin Management
- `:Lazy` - Open Lazy.nvim interface
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - Profile startup time

### LSP Commands
- `:Mason` - Open Mason interface
- `:LspInfo` - Show LSP client info
- `:LspRestart` - Restart LSP clients

### File Operations
- `:Neotree` - Toggle file explorer
- `:Telescope find_files` - Fuzzy file finder
- `:Telescope live_grep` - Search in files

## Maintenance Notes

### Regular Maintenance
- Update plugins occasionally with `:Lazy update`
- lazy-lock.json tracks exact versions for reproducibility
- Check `:checkhealth` for configuration issues

### When Adding Language Support
1. Add LSP server to Mason configuration
2. Create settings file in `lua/plugins/lsp/settings/`
3. Add formatter to none-ls if needed
4. Test with sample files

### Performance Considerations
- Lazy loading configured for most plugins
- Core plugins load on startup, others on demand
- Use `:Lazy profile` to identify slow plugins

## File Editing Guidelines

### When Modifying Plugin Configs
- Always read the existing file first to understand structure
- Follow the established pattern of error handling with `pcall`
- Maintain lazy loading configuration
- Test changes immediately

### Configuration Changes
- Options changes go in `lua/config/options.lua`
- New keymaps in `lua/config/keymaps.lua`
- Plugin-specific settings in respective plugin files
- Follow 2-space indentation consistently

## Troubleshooting

### LSP Issues
- Use `:LspInfo` to check which LSP clients are attached to current buffer
- Use `:Mason` to verify language servers are installed
- Check `:checkhealth mason` and `:checkhealth lsp` for diagnostics
- For Biome LSP specifically: ensure `biome.json` exists in project root

### Common LSP Problems
- **Biome LSP not attaching**: Verify biome.json exists and contains valid configuration
- **Multiple formatters conflicting**: Check none-ls and LSP formatter settings in handlers.lua
- **LSP not starting**: Check Mason installation and server configuration files

### Plugin Loading Issues
- Use `:Lazy` to check plugin status and errors
- Check if plugins are properly lazy-loaded with correct triggers
- Use `:Lazy profile` to identify startup performance issues

### Configuration Changes Not Taking Effect
- Restart Neovim completely for major configuration changes
- Use `:LspRestart` for LSP-related changes
- Clear plugin cache with `:Lazy clean` if needed

This configuration provides a full-featured development environment with modern Neovim capabilities while maintaining performance through lazy loading and careful plugin selection.