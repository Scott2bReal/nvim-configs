local comment_current_line = function()
	local window = vim.api.nvim_get_current_win()
	local line = vim.api.nvim_win_get_cursor(window)[1]
	require("mini.comment").toggle_lines(line, line)
end

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
		show_help = true, -- show help message on the command line when the popup is visible
	},
	config = function(_, opts)
		local status_ok, which_key = pcall(require, "which-key")
		if not status_ok then
			vim.notify("Error loading whichkey")
			return
		end

		--- Telescope builtin functions
		local telescope = require("telescope.builtin")
		local telescope_themes = require("telescope.themes")

		-- 	mode = "n", -- NORMAL mode
		-- 	prefix = "<leader>",
		-- 	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		-- 	silent = true, -- use `silent` when creating keymaps
		-- 	noremap = true, -- use `noremap` when creating keymaps
		-- 	nowait = true, -- use `nowait` when creating keymaps

		local DEFAULT_CONFIG = {
			nowait = true,
			remap = false,
		}

		local add_default_config_to_table = function(table)
			for _, mapping in ipairs(table) do
				for key, value in pairs(DEFAULT_CONFIG) do
					if mapping[key] == nil then
						mapping[key] = value
					end
				end
			end
			return table
		end

		local create_mappings_with_defaults = function(mappings)
			local mappings_with_defaults = {}
			for _, mapping in ipairs(mappings) do
				local mapping_with_defaults = vim.tbl_deep_extend("keep", mapping, DEFAULT_CONFIG)
				table.insert(mappings_with_defaults, mapping_with_defaults)
			end
			return mappings_with_defaults
		end

		--- Mappings will have a default configuration injected after
		local mappings = {
			{
				"<leader>/",
				comment_current_line,
				desc = "Comment",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>f",
				telescope.find_files,
				desc = "Find files",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>F",
				function()
					telescope.live_grep(telescope_themes.get_ivy())
				end,
				desc = "Find Text",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>H",
				"<cmd>!firefox %<cr>",
				desc = "open current HTML file in firefox",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>c",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Close Buffer",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>d",
				function()
					require("gitsigns").diffthis("~1")
				end,
				desc = "Toggle diff overlay",
				unpack(DEFAULT_CONFIG),
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
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>h",
				"<cmd>nohlsearch<CR>",
				desc = "No Highlight",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>l",
				group = "LSP",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lI",
				"<cmd>Mason<cr>",
				desc = "Installer Info",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lR",
				"<cmd>LspRestart<cr>",
				desc = "Restart LSP",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lf",
				require("conform").format,
				desc = "Format",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>li",
				"<cmd>LspInfo<cr>",
				desc = "Info",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lj",
				vim.lsp.diagnostic.goto_next,
				desc = "Next Diagnostic",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lk",
				vim.lsp.diagnostic.goto_prev,
				desc = "Prev Diagnostic",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>ll",
				vim.lsp.codelens.run,
				desc = "CodeLens Action",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lq",
				vim.lsp.diagnostic.set_loclist,
				desc = "Quickfix",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lr",
				vim.lsp.buf.rename,
				desc = "Rename",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lt",
				group = "Typescript",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lta",
				"<cmd>TSToolsAddMissingImports<cr>",
				desc = "Add Missing Imports",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>ltf",
				"<cmd>TSToolsFixAll<cr>",
				desc = "Fix All",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>ltg",
				"<cmd>TSToolsGoToSourceDefinition<cr>",
				desc = "Go To Source Definition",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lto",
				"<cmd>TSToolsOrganizeImports<cr>",
				desc = "Organize Imports",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>ltr",
				"<cmd>TSToolsRenameFile<cr>",
				desc = "Rename File",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>ltu",
				"<cmd>TypesciptRemoveUnused<cr>",
				desc = "Remove Unused Variables",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>lw",
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				desc = "Workspace Diagnostics",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>n",
				group = "Notifications",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>nh",
				"<cmd>lua MiniNotify.show_history()<cr>",
				desc = "Notification History",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>p",
				group = "Plugins",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>ph",
				"<cmd>Lazy home<cr>",
				desc = "Home",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>pi",
				"<cmd>Lazy install<cr>",
				desc = "Install",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>pp",
				"<cmd>Lazy profile<cr>",
				desc = "Profile",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>ps",
				"<cmd>Lazy sync<cr>",
				desc = "Sync",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>pu",
				"<cmd>Lazy update<cr>",
				desc = "Update",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>s",
				group = "Search",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sb",
				function()
					telescope.buffers(telescope_themes.get_dropdown({ previewer = false }))
				end,
				desc = "Search buffers",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sc",
				function()
					telescope.colorscheme(telescope_themes.get_dropdown())
				end,
				desc = "Search colorschemes",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sd",
				function()
					telescope.find_files({ hidden = true })
				end,
				desc = "Include Dotfiles",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sh",
				function()
					telescope.help_tags(telescope_themes.get_ivy())
				end,
				desc = "Find Help",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sk",
				function()
					telescope.keymaps(telescope_themes.get_ivy())
				end,
				desc = "Keymaps",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sn",
				function()
					telescope.find_files({
						cwd = vim.fn.stdpath("config"),
					})
				end,
				desc = "Search neovim config",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sr",
				telescope.oldfiles,
				desc = "Open Recent File",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sR",
				telescope.registers,
				desc = "Search Registers",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sD",
				telescope.diagnostics,
				desc = "Search Diagnostics",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>sS",
				telescope.lsp_dynamic_workspace_symbols,
				desc = "Workspace Symbols",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>z",
				group = "Misc.",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>zc",
				"<cmd>ColorizerToggle<cr>",
				desc = "Colorizer",
				unpack(DEFAULT_CONFIG),
			},
			{
				"<leader>zz",
				function()
					vim.notify("Toggling Copilot auto suggestions")
					require("copilot.suggestion").toggle_auto_trigger()
				end,
				desc = "Toggle GitHub Copilot",
				unpack(DEFAULT_CONFIG),
			},
		}

		-- local vmappings = {
		--   {
		--     "<leader>/",
		--     comment_visual_selection,
		--     desc = "Comment",
		--     mode = "v",
		--     unpack(DEFAULT_CONFIG),
		--   },
		-- }

		which_key.setup(opts)
		which_key.add(mappings)
		-- which_key.add(vmappings)
	end,
}
