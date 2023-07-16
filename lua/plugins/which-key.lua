return {
	"folke/which-key.nvim",
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
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "rounded", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
	},
	config = function(_, opts)
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			vim.notify("Error loading whichkey")
			return
		end

		local configs = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}

		local mappings = {
			["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
			["a"] = { "<cmd>Alpha<cr>", "Alpha" },
			["b"] = {
				"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
				"Buffers",
			},
			-- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
			["e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },
			["d"] = { "<cmd>Neotree diagnostics toggle bottom<cr>", "Diagnostics" },
			["c"] = { "<cmd>Bdelete<CR>", "Close Buffer" },
			-- ["c"] = { "<leader>c", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
			["H"] = { "<cmd>!firefox %<cr>", "open current HTML file in firefox" },
			["f"] = {
				-- "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
				"<cmd>Telescope find_files<cr>",
				"Find files",
			},
			["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
			["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
			["C"] = { "<cmd>DeleteHiddenBuffers<CR>", "Close All Buffers But One" },
			["A"] = { "<cmd>bufdo Bdelete <CR><cmd>Alpha<CR>", "Close All Buffers To Alpha" },
			p = {
				name = "Plugins",
				h = { "<cmd>Lazy home<cr>", "Home" },
				i = { "<cmd>Lazy install<cr>", "Install" },
				p = { "<cmd>Lazy profile<cr>", "Profile" },
				s = { "<cmd>Lazy sync<cr>", "Sync" },
				u = { "<cmd>Lazy update<cr>", "Update" },
			},
			g = {
				name = "Git",
				g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
				j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
				r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
				R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
				s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
				u = {
					"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
					"Undo Stage Hunk",
				},
				o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
				d = {
					"<cmd>Gitsigns diffthis HEAD<cr>",
					"Diff",
				},
			},
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
				d = {
					"<cmd>Telescope lsp_document_diagnostics<cr>",
					"Document Diagnostics",
				},
				w = {
					"<cmd>Telescope lsp_workspace_diagnostics<cr>",
					"Workspace Diagnostics",
				},
				f = { "<cmd>lua vim.lsp.buf.format { timeout_ms = 5000 }<cr>", "Format" },
				i = { "<cmd>LspInfo<cr>", "Info" },
				I = { "<cmd>Mason<cr>", "Installer Info" },
				j = {
					"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
					"Next Diagnostic",
				},
				k = {
					"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
					"Prev Diagnostic",
				},
				l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
				q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
				r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
				R = { "<cmd>LspRestart<cr>", "Restart LSP" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
				S = {
					"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
					"Workspace Symbols",
				},
				t = {
					name = "Typescript",
					a = { "<cmd>TypescriptAddMissingImports<cr>", "Add Missing Imports" },
					f = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
					g = { "<cmd>TypescriptGoToSourceDefinition<cr>", "Go To Source Definition" },
					o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
					r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
					u = { "<cmd>TypesciptRemoveUnused<cr>", "Remove Unused Variables" },
				},
			},
			m = {
				name = "Markdown",
				g = { "<cmd>Glow<cr>", "Open preview in glow" },
				p = { "<cmd>MarkdownPreviewToggle<cr>", "Open preview in browser" },
			},
			s = {
				name = "Search",
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
				d = { "<cmd>Telescope find_files hidden=true<cr>", "Include Dotfiles" },
				h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
				M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				R = { "<cmd>Telescope registers<cr>", "Registers" },
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				C = { "<cmd>Telescope commands<cr>", "Commands" },
			},
			t = {
				name = "Terminal",
				i = { "<cmd>lua _IRB_TOGGLE()<cr>", "IRB" },
				n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
				u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
				t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
				p = { "<cmd>lua _PSQL_TOGGLE()<cr>", "PSQL" },
				P = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
				f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
				h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
				v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
			},
			z = {
				name = "Misc.",
				c = { "<cmd>ColorizerToggle<cr>", "Colorizer" },
				g = { "<cmd>ChatGPT<cr>", "ChatGPT" },
				r = { "<cmd>source $MYVIMRC<cr>", "Reload Neovim config" },
				z = { "<cmd>Copilot toggle<cr>", "Toggle GitHub Copilot" },
			},
		}

		local vopts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		}
		local vmappings = {
			["/"] = { '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', "Comment" },
		}

		which_key.setup(opts)
		which_key.register(mappings, configs)
		which_key.register(vmappings, vopts)
	end,
}
