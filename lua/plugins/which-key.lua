local comment_current_line = function()
  local window = vim.api.nvim_get_current_win()
  local line = vim.api.nvim_win_get_cursor(window)[1]
  require("mini.comment").toggle_lines(line, line)
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    plugins = {
      marks = true,   -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false,  -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true,   -- default bindings on <c-w>
        nav = true,       -- misc bindings to work with windows
        z = true,         -- bindings for folds, spelling and others prefixed with z
        g = true,         -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3,                 -- spacing between columns
      align = "left",              -- align columns left, center or right
    },
    show_help = true,              -- show help message on the command line when the popup is visible
  },
  config = function(_, opts)
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      vim.notify("Error loading whichkey")
      return
    end

    -- local configs = {
    -- 	mode = "n", -- NORMAL mode
    -- 	prefix = "<leader>",
    -- 	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    -- 	silent = true, -- use `silent` when creating keymaps
    -- 	noremap = true, -- use `noremap` when creating keymaps
    -- 	nowait = true, -- use `nowait` when creating keymaps
    -- }

    local mappings = {
      {
        "<leader>/",
        comment_current_line,
        desc = "Comment",
        nowait = true,
        remap = false,
      },
      {
        "<leader>a",
        desc = "Avante",
        nowait = true,
        remap = false,
      },
      {
        "<leader>F",
        "<cmd>Telescope live_grep theme=ivy<cr>",
        desc = "Find Text",
        nowait = true,
        remap = false,
      },
      {
        "<leader>H",
        "<cmd>!firefox %<cr>",
        desc = "open current HTML file in firefox",
        nowait = true,
        remap = false,
      },
      {
        "<leader>P",
        "<cmd>Telescope projects<cr>",
        desc = "Projects",
        nowait = true,
        remap = false,
      },
      {
        "<leader>b",
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        desc = "Buffers",
        nowait = true,
        remap = false,
      },
      {
        "<leader>c",
        "<cmd>lua MiniBufremove.delete(0, false)<CR>",
        desc = "Close Buffer",
        nowait = true,
        remap = false,
      },
      {
        "<leader>d",
        "<cmd>Neotree diagnostics toggle bottom<cr>",
        desc = "Diagnostics",
        nowait = true,
        remap = false,
      },
      {
        "<leader>e",
        "<cmd>lua MiniFiles.open()<cr>",
        desc = "Explorer",
        nowait = true,
        remap = false,
      },
      {
        "<leader>f",
        "<cmd>Telescope find_files<cr>",
        desc = "Find files",
        nowait = true,
        remap = false,
      },
      {
        "<leader>g",
        group = "Git",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gR",
        "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
        desc = "Reset Buffer",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gb",
        "<cmd>Telescope git_branches<cr>",
        desc = "Checkout branch",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gc",
        "<cmd>Telescope git_commits<cr>",
        desc = "Checkout commit",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gd",
        "<cmd>Gitsigns diffthis HEAD<cr>",
        desc = "Diff",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gg",
        "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
        desc = "Lazygit",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gj",
        "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
        desc = "Next Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gk",
        "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
        desc = "Prev Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gl",
        "<cmd>lua require 'gitsigns'.blame_line()<cr>",
        desc = "Blame",
        nowait = true,
        remap = false,
      },
      {
        "<leader>go",
        "<cmd>Telescope git_status<cr>",
        desc = "Open changed file",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gp",
        "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
        desc = "Preview Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gr",
        "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
        desc = "Reset Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gs",
        "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
        desc = "Stage Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>gu",
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        desc = "Undo Stage Hunk",
        nowait = true,
        remap = false,
      },
      {
        "<leader>h",
        "<cmd>nohlsearch<CR>",
        desc = "No Highlight",
        nowait = true,
        remap = false,
      },
      {
        "<leader>l",
        group = "LSP",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lI",
        "<cmd>Mason<cr>",
        desc = "Installer Info",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lR",
        "<cmd>LspRestart<cr>",
        desc = "Restart LSP",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Workspace Symbols",
        nowait = true,
        remap = false,
      },
      {
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        desc = "Code Action",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ld",
        "<cmd>Telescope lsp_document_diagnostics<cr>",
        desc = "Document Diagnostics",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lf",
        "<cmd>lua vim.lsp.buf.format { timeout_ms = 5000 }<cr>",
        desc = "Format",
        nowait = true,
        remap = false,
      },
      {
        "<leader>li",
        "<cmd>LspInfo<cr>",
        desc = "Info",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lj",
        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        desc = "Next Diagnostic",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lk",
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
        desc = "Prev Diagnostic",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ll",
        "<cmd>lua vim.lsp.codelens.run()<cr>",
        desc = "CodeLens Action",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lq",
        "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
        desc = "Quickfix",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lr",
        "<cmd>lua vim.lsp.buf.rename()<cr>",
        desc = "Rename",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ls",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Document Symbols",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lt",
        group = "Typescript",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lta",
        "<cmd>TSToolsAddMissingImports<cr>",
        desc = "Add Missing Imports",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ltf",
        "<cmd>TSToolsFixAll<cr>",
        desc = "Fix All",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ltg",
        "<cmd>TSToolsGoToSourceDefinition<cr>",
        desc = "Go To Source Definition",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lto",
        "<cmd>TSToolsOrganizeImports<cr>",
        desc = "Organize Imports",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ltr",
        "<cmd>TSToolsRenameFile<cr>",
        desc = "Rename File",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ltu",
        "<cmd>TypesciptRemoveUnused<cr>",
        desc = "Remove Unused Variables",
        nowait = true,
        remap = false,
      },
      {
        "<leader>lw",
        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics",
        nowait = true,
        remap = false,
      },
      {
        "<leader>m",
        group = "Markdown",
        nowait = true,
        remap = false,
      },
      {
        "<leader>mg",
        "<cmd>Glow<cr>",
        desc = "Open preview in glow",
        nowait = true,
        remap = false,
      },
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Open preview in browser",
        nowait = true,
        remap = false,
      },
      {
        "<leader>o",
        group = "Oil",
        nowait = true,
        remap = false,
      },
      {
        "<leader>oo",
        "<cmd>Oil .<cr>",
        desc = "Open Oil in the current directory",
        nowait = true,
        remap = false,
      },
      {
        "<leader>p",
        group = "Plugins",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ph",
        "<cmd>Lazy home<cr>",
        desc = "Home",
        nowait = true,
        remap = false,
      },
      {
        "<leader>pi",
        "<cmd>Lazy install<cr>",
        desc = "Install",
        nowait = true,
        remap = false,
      },
      {
        "<leader>pp",
        "<cmd>Lazy profile<cr>",
        desc = "Profile",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ps",
        "<cmd>Lazy sync<cr>",
        desc = "Sync",
        nowait = true,
        remap = false,
      },
      {
        "<leader>pu",
        "<cmd>Lazy update<cr>",
        desc = "Update",
        nowait = true,
        remap = false,
      },
      {
        "<leader>s",
        group = "Search",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sd",
        "<cmd>Telescope find_files hidden=true<cr>",
        desc = "Include Dotfiles",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sh",
        "<cmd>Telescope help_tags<cr>",
        desc = "Find Help",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sk",
        "<cmd>Telescope keymaps<cr>",
        desc = "Keymaps",
        nowait = true,
        remap = false,
      },
      {
        "<leader>sr",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Open Recent File",
        nowait = true,
        remap = false,
      },
      {
        "<leader>t",
        group = "Terminal",
        nowait = true,
        remap = false,
      },
      {
        "<leader>tP",
        "<cmd>lua _PYTHON_TOGGLE()<cr>",
        desc = "Python",
        nowait = true,
        remap = false,
      },
      {
        "<leader>tf",
        "<cmd>ToggleTerm direction=float<cr>",
        desc = "Float",
        nowait = true,
        remap = false,
      },
      {
        "<leader>th",
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        desc = "Horizontal",
        nowait = true,
        remap = false,
      },
      {
        "<leader>ti",
        "<cmd>lua _IRB_TOGGLE()<cr>",
        desc = "IRB",
        nowait = true,
        remap = false,
      },
      {
        "<leader>tn",
        "<cmd>lua _NODE_TOGGLE()<cr>",
        desc = "Node",
        nowait = true,
        remap = false,
      },
      {
        "<leader>tp",
        "<cmd>lua _PSQL_TOGGLE()<cr>",
        desc = "PSQL",
        nowait = true,
        remap = false,
      },
      {
        "<leader>tt",
        "<cmd>lua _HTOP_TOGGLE()<cr>",
        desc = "Htop",
        nowait = true,
        remap = false,
      },
      {
        "<leader>tu",
        "<cmd>lua _NCDU_TOGGLE()<cr>",
        desc = "NCDU",
        nowait = true,
        remap = false,
      },
      {
        "<leader>tv",
        "<cmd>ToggleTerm size=80 direction=vertical<cr>",
        desc = "Vertical",
        nowait = true,
        remap = false,
      },
      {
        "<leader>z",
        group = "Misc.",
        nowait = true,
        remap = false,
      },
      {
        "<leader>zc",
        "<cmd>ColorizerToggle<cr>",
        desc = "Colorizer",
        nowait = true,
        remap = false,
      },
      {
        "<leader>zd",
        "<cmd>lua MiniDiff.toggle_overlay()<cr>",
        desc = "Toggle Diff Overlay",
        nowait = true,
        remap = false,
      },
      {
        "<leader>zg",
        "<cmd>ChatGPT<cr>",
        desc = "ChatGPT",
        nowait = true,
        remap = false,
      },
      {
        "<leader>zr",
        "<cmd>source $MYVIMRC<cr>",
        desc = "Reload Neovim config",
        nowait = true,
        remap = false,
      },
      {
        "<leader>zz",
        "<cmd>Copilot toggle<cr>",
        desc = "Toggle GitHub Copilot",
        nowait = true,
        remap = false,
      },
    }

    -- local vmappings = {
    --   {
    --     "<leader>/",
    --     comment_visual_selection,
    --     desc = "Comment",
    --     mode = "v",
    --     nowait = true,
    --     remap = false,
    --   },
    -- }

    which_key.setup(opts)
    which_key.add(mappings)
    -- which_key.add(vmappings)
  end,
}
