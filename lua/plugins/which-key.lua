return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
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
		win = {
			border = "single", -- none, single, double, shadow
			-- position = "bottom", -- bottom, top
			-- margin = { 1, 1 }, -- extra window margin [top, right, bottom, left]
			-- padding = { 2, 2 }, -- extra window padding [top, right, bottom, left]
			-- wo = {
			-- 	winblend = 0,
			-- },
		},
		-- layout = {
		-- 	height = { min = 4, max = 25 }, -- min and max height of the columns
		-- 	width = { min = 20, max = 50 }, -- min and max width of the columns
		-- 	spacing = 3, -- spacing between columns
		-- 	align = "left", -- align columns left, center or right
		-- },
		preset = "modern",
		show_help = true, -- show help message on the command line when the popup is visible
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

		local config = {
			nowait = true,
			remap = false,
		}

		local mappings = {
			{
				"<leader>/",
				'<cmd>lua require("Comment.api").toggle.linewise.current()<CR>',
				desc = "Comment",
			},
			{
				"<leader>F",
				"<cmd>Telescope live_grep theme=ivy<cr>",
				desc = "Find Text",
			},
			{
				"<leader>H",
				"<cmd>!firefox %<cr>",
				desc = "open current HTML file in firefox",
			},
			{
				"<leader>P",
				"<cmd>Telescope projects<cr>",
				desc = "Projects",
			},
			{
				"<leader>a",
				"<cmd>Alpha<cr>",
				desc = "Alpha",
			},
			{
				"<leader>b",
				"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
				desc = "Buffers",
			},
			{
				"<leader>c",
				"<cmd>lua MiniBufremove.delete(0, false)<CR>",
				desc = "Close Buffer",
			},
			{
				"<leader>d",
				"<cmd>Neotree diagnostics toggle bottom<cr>",
				desc = "Diagnostics",
			},
			{
				"<leader>e",
				"<cmd>Neotree toggle<cr>",
				desc = "Explorer",
			},
			{
				"<leader>f",
				"<cmd>Telescope find_files<cr>",
				desc = "Find files",
			},
			{
				"<leader>g",
				group = "Git",
			},
			{
				"<leader>gR",
				"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
				desc = "Reset Buffer",
			},
			{
				"<leader>gb",
				"<cmd>Telescope git_branches<cr>",
				desc = "Checkout branch",
			},
			{
				"<leader>gc",
				"<cmd>Telescope git_commits<cr>",
				desc = "Checkout commit",
			},
			{
				"<leader>gd",
				"<cmd>Gitsigns diffthis HEAD<cr>",
				desc = "Diff",
			},
			{
				"<leader>gg",
				"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
				desc = "Lazygit",
			},
			{
				"<leader>gj",
				"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
				desc = "Next Hunk",
			},
			{
				"<leader>gk",
				"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
				desc = "Prev Hunk",
			},
			{
				"<leader>gl",
				"<cmd>lua require 'gitsigns'.blame_line()<cr>",
				desc = "Blame",
			},
			{
				"<leader>go",
				"<cmd>Telescope git_status<cr>",
				desc = "Open changed file",
			},
			{
				"<leader>gp",
				"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
				desc = "Preview Hunk",
			},
			{
				"<leader>gr",
				"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
				desc = "Reset Hunk",
			},
			{
				"<leader>gs",
				"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
				desc = "Stage Hunk",
			},
			{
				"<leader>gu",
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				desc = "Undo Stage Hunk",
			},
			{
				"<leader>h",
				"<cmd>nohlsearch<CR>",
				desc = "No Highlight",
			},
			{
				"<leader>l",
				group = "LSP",
			},
			{
				"<leader>lI",
				"<cmd>Mason<cr>",
				desc = "Installer Info",
			},
			{
				"<leader>lR",
				"<cmd>LspRestart<cr>",
				desc = "Restart LSP",
			},
			{
				"<leader>lS",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				desc = "Workspace Symbols",
			},
			{
				"<leader>la",
				"<cmd>lua vim.lsp.buf.code_action()<cr>",
				desc = "Code Action",
			},
			{
				"<leader>ld",
				"<cmd>Telescope lsp_document_diagnostics<cr>",
				desc = "Document Diagnostics",
			},
			{
				"<leader>lf",
				"<cmd>lua vim.lsp.buf.format { timeout_ms = 5000 }<cr>",
				desc = "Format",
			},
			{
				"<leader>li",
				"<cmd>LspInfo<cr>",
				desc = "Info",
			},
			{
				"<leader>lj",
				"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
				desc = "Next Diagnostic",
			},
			{
				"<leader>lk",
				"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
				desc = "Prev Diagnostic",
			},
			{
				"<leader>ll",
				"<cmd>lua vim.lsp.codelens.run()<cr>",
				desc = "CodeLens Action",
			},
			{
				"<leader>lq",
				"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
				desc = "Quickfix",
			},
			{
				"<leader>lr",
				"<cmd>lua vim.lsp.buf.rename()<cr>",
				desc = "Rename",
			},
			{
				"<leader>ls",
				"<cmd>Telescope lsp_document_symbols<cr>",
				desc = "Document Symbols",
			},
			{
				"<leader>lt",
				group = "Typescript",
			},
			{
				"<leader>lta",
				"<cmd>TSToolsAddMissingImports<cr>",
				desc = "Add Missing Imports",
			},
			{
				"<leader>ltf",
				"<cmd>TSToolsFixAll<cr>",
				desc = "Fix All",
			},
			{
				"<leader>ltg",
				"<cmd>TSToolsGoToSourceDefinition<cr>",
				desc = "Go To Source Definition",
			},
			{
				"<leader>lto",
				"<cmd>TSToolsOrganizeImports<cr>",
				desc = "Organize Imports",
			},
			{
				"<leader>ltr",
				"<cmd>TSToolsRenameFile<cr>",
				desc = "Rename File",
			},
			{
				"<leader>ltu",
				"<cmd>TypesciptRemoveUnused<cr>",
				desc = "Remove Unused Variables",
			},
			{
				"<leader>lw",
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>m",
				group = "Markdown",
			},
			{
				"<leader>mg",
				"<cmd>Glow<cr>",
				desc = "Open preview in glow",
			},
			{
				"<leader>mp",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Open preview in browser",
			},
			{
				"<leader>o",
				group = "Oil",
			},
			{
				"<leader>oo",
				"<cmd>Oil .<cr>",
				desc = "Open Oil in current directory",
			},
			{
				"<leader>p",
				group = "Plugins",
			},
			{
				"<leader>ph",
				"<cmd>Lazy home<cr>",
				desc = "Home",
			},
			{
				"<leader>pi",
				"<cmd>Lazy install<cr>",
				desc = "Install",
			},
			{
				"<leader>pp",
				"<cmd>Lazy profile<cr>",
				desc = "Profile",
			},
			{
				"<leader>ps",
				"<cmd>Lazy sync<cr>",
				desc = "Sync",
			},
			{
				"<leader>pu",
				"<cmd>Lazy update<cr>",
				desc = "Update",
			},
			{
				"<leader>s",
				group = "Search",
			},
			{
				"<leader>sC",
				"<cmd>Telescope commands<cr>",
				desc = "Commands",
			},
			{
				"<leader>sM",
				"<cmd>Telescope man_pages<cr>",
				desc = "Man Pages",
			},
			{
				"<leader>sR",
				"<cmd>Telescope registers<cr>",
				desc = "Registers",
			},
			{
				"<leader>sb",
				"<cmd>Telescope git_branches<cr>",
				desc = "Checkout branch",
			},
			{
				"<leader>sc",
				"<cmd>Telescope colorscheme<cr>",
				desc = "Colorscheme",
			},
			{
				"<leader>sd",
				"<cmd>Telescope find_files hidden=true<cr>",
				desc = "Include Dotfiles",
			},
			{
				"<leader>sh",
				"<cmd>Telescope help_tags<cr>",
				desc = "Find Help",
			},
			{
				"<leader>sk",
				"<cmd>Telescope keymaps<cr>",
				desc = "Keymaps",
			},
			{
				"<leader>sr",
				"<cmd>Telescope oldfiles<cr>",
				desc = "Open Recent File",
			},
			{
				"<leader>t",
				group = "Terminal",
			},
			{
				"<leader>tP",
				"<cmd>lua _PYTHON_TOGGLE()<cr>",
				desc = "Python",
			},
			{
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<cr>",
				desc = "Float",
			},
			{
				"<leader>th",
				"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
				desc = "Horizontal",
			},
			{
				"<leader>ti",
				"<cmd>lua _IRB_TOGGLE()<cr>",
				desc = "IRB",
			},
			{
				"<leader>tn",
				"<cmd>lua _NODE_TOGGLE()<cr>",
				desc = "Node",
			},
			{
				"<leader>tp",
				"<cmd>lua _PSQL_TOGGLE()<cr>",
				desc = "PSQL",
			},
			{
				"<leader>tt",
				"<cmd>lua _HTOP_TOGGLE()<cr>",
				desc = "Htop",
			},
			{
				"<leader>tu",
				"<cmd>lua _NCDU_TOGGLE()<cr>",
				desc = "NCDU",
			},
			{
				"<leader>tv",
				"<cmd>ToggleTerm size=80 direction=vertical<cr>",
				desc = "Vertical",
			},
			{
				"<leader>z",
				group = "Misc.",
			},
			{
				"<leader>zc",
				"<cmd>ColorizerToggle<cr>",
				desc = "Colorizer",
			},
			{
				"<leader>zz",
				"<cmd>Copilot toggle<cr>",
				desc = "Toggle GitHub Copilot",
			},
			{
				"<leader>/",
				'<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
				desc = "Comment",
				mode = "v",
				nowait = true,
				remap = false,
			},
		}

		local vmappings = {
			{
				"<leader>/",
				'<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
				desc = "Comment",
				mode = "v",
				nowait = true,
				remap = false,
			},
		}

		which_key.setup(opts)
		which_key.add(mappings, config)
		which_key.add(vmappings)
	end,
}
