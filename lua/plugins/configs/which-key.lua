require("which-key").setup({
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
})

local DEFAULT_CONFIG = {
	silent = true,
	nowait = true,
	noremap = true,
}

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

local fzf_lua = require("fzf-lua")

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
		"<leader>c",
		function()
			require("mini.bufremove").delete(0, false)
		end,
		desc = "Close Buffer",
	},

	{
		"<leader>e",
		function()
			local mini_files = require("mini.files")
			if vim.o.filetype == "ministarter" then
				mini_files.open()
				return
			end
			if not mini_files.close() then
				mini_files.open(vim.api.nvim_buf_get_name(0))
			end
		end,
		desc = "Toggle explorer",
	},
	{
		"<leader>l",
		group = "LSP",
	},
	{
		"<leader>lci",
		"<cmd>ConformInfo<cr>",
		desc = "Conform Info",
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
		function()
			if not require("conform").format() then
				vim.lsp.buf.format()
			end
		end,
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
		"<leader>pa",
		function()
			if not (vim.o.filetype == "nvim-pack") then
				vim.notify("Not in a vimpack buffer", vim.log.levels.ERROR)
				return
			end
			vim.lsp.buf.code_action()
		end,
		desc = "Plugin actions",
	},
	{
		"<leader>ph",
		function()
			vim.pack.update(nil, { offline = true })
		end,
		desc = "Plugins home",
	},
	{
		"<leader>pd",
		function()
			vim.iter(vim.pack.get())
				:filter(function(x)
					return not x.active
				end)
				:map(function(x)
					return x.spec.name
				end)
				:totable()
		end,
		desc = "Remove non-active plugins",
	},
	{
		"<leader>pu",
		vim.pack.update,
		desc = "Update plugins",
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
})
require("which-key").add(mappings)
