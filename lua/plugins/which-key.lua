return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	---@module "which-key"
	---@type wk.Opts
	opts = {
		preset = "modern",
		plugins = {
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		layout = {
			height = { min = 4, max = 25 },
			width = { min = 20, max = 50 },
			spacing = 3,
			align = "left",
		},
		show_help = true,
	},
	config = function(_, opts)
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			vim.notify("Error loading whichkey")
			return
		end

		local fzf_lua = require("fzf-lua")

		local DEFAULT_CONFIG = {
			silent = true,
			nowait = true,
			noremap = true,
		}

		--- Inject default config values into mappings that don't have them explicitly set
		local with_default_configs = function(mappings)
			for _, mapping in ipairs(mappings) do
				for key, value in pairs(DEFAULT_CONFIG) do
					if mapping[key] == nil then
						mapping[key] = value
					end
				end
			end
			return mappings
		end

		local mappings = with_default_configs({
			{
				"<leader>/",
				function()
					local window = vim.api.nvim_get_current_win()
					local line = vim.api.nvim_win_get_cursor(window)[1]
					require("mini.comment").toggle_lines(line, line)
				end,
				desc = "Comment current line",
			},
			{
				"<leader>f",
				fzf_lua.files,
				desc = "Find files",
			},
			{
				"<leader>F",
				function()
					fzf_lua.live_grep({ profile = "ivy" })
				end,
				desc = "Find Text",
			},
			{
				"<C-t>",
				function()
					fzf_lua.live_grep({ profile = "ivy" })
				end,
				desc = "Find Text",
			},
			{
				"<leader>H",
				"<cmd>!firefox %<cr>",
				desc = "open current HTML file in firefox",
			},
			{
				"<leader>c",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Close Buffer",
			},
			{
				"<leader>d",
				function()
					require("gitsigns").diffthis("~1")
				end,
				desc = "Toggle diff overlay",
			},
			{
				"<leader>e",
				function()
					local mini_files = require("mini.files")
					if not mini_files.close() then
						mini_files.open(vim.api.nvim_buf_get_name(0))
					end
				end,
				desc = "Toggle explorer",
			},
			{
				"<leader>g",
				group = "Git",
			},
			{
				"<leader>gl",
				function()
					require("gitsigns").blame_line()
				end,
				desc = "Blame line",
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
				"<cmd>lsp restart<cr>",
				desc = "Restart LSP",
			},
			{
				"<leader>lf",
				require("conform").format,
				desc = "Format",
			},
			{
				"<leader>li",
				"<cmd>checkhealth vim.lsp<cr>",
				desc = "Info",
			},
			{
				"<leader>lj",
				vim.lsp.diagnostic.goto_next,
				desc = "Next Diagnostic",
			},
			{
				"<leader>lk",
				vim.lsp.diagnostic.goto_prev,
				desc = "Prev Diagnostic",
			},
			{
				"<leader>ll",
				vim.lsp.codelens.run,
				desc = "CodeLens Action",
			},
			{
				"<leader>lq",
				vim.lsp.diagnostic.set_loclist,
				desc = "Quickfix",
			},
			{
				"<leader>lr",
				vim.lsp.buf.rename,
				desc = "Rename",
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
				"<leader>n",
				group = "Notifications",
			},
			{
				"<leader>nh",
				"<cmd>lua MiniNotify.show_history()<cr>",
				desc = "Notification History",
			},
			{
				"<leader>p",
				group = "Plugins",
			},
			{
				"<leader>pc",
				"<cmd>Lazy check<cr>",
				desc = "Check",
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
				"<leader>rr",
				"<cmd>restart<cr>",
				desc = "Restart Neovim",
			},
			{
				"<leader>s",
				group = "Search",
			},
			{
				"<leader>sb",
				function()
					fzf_lua.buffers({ previewer = false })
				end,
				desc = "Search buffers",
			},
			{
				"<leader>sc",
				function()
					fzf_lua.colorschemes({ previewer = false })
				end,
				desc = "Search colorschemes",
			},
			{
				"<leader>sC",
				group = "Commands",
			},
			{
				"<leader>sCA",
				fzf_lua.commands,
				desc = "Available commands",
			},
			{
				"<leader>sCH",
				fzf_lua.command_history,
				desc = "Command History",
			},
			{
				"<leader>sd",
				function()
					fzf_lua.files({ hidden = true })
				end,
				desc = "Include Dotfiles",
			},
			{
				"<leader>sh",
				function()
					fzf_lua.help_tags({ previewer = false, theme = "ivy" })
				end,
				desc = "Find Help",
			},
			{
				"<leader>sk",
				function()
					fzf_lua.keymaps({ previewer = false, theme = "ivy" })
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sn",
				function()
					fzf_lua.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Search neovim config",
			},
			{
				"<leader>sr",
				function()
					fzf_lua.oldfiles()
				end,
				desc = "Open Recent File",
			},
			{
				"<leader>sR",
				fzf_lua.registers,
				desc = "Search Registers",
			},
			{
				"<leader>sD",
				fzf_lua.diagnostics_workspace,
				desc = "Search Diagnostics",
			},
			{
				"<leader>sS",
				fzf_lua.lsp_document_symbols,
				desc = "Workspace Symbols",
			},
			{
				"<leader>t",
				group = "Treesitter",
			},
			{
				"<leader>ts",
				vim.treesitter.start,
				desc = "Start Treesitter",
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
				function()
					vim.notify("Toggling Copilot auto suggestions")
					require("copilot.suggestion").toggle_auto_trigger()
				end,
				desc = "Toggle GitHub Copilot",
			},
		})

		-- local vmappings = {
		--   {
		--     "<leader>/",
		--     comment_visual_selection,
		--     desc = "Comment",
		--     mode = "v",
		--   },
		-- }

		which_key.setup(opts)
		which_key.add(mappings)
	end,
}
