--- Wrapper to globally set highlight group colors
---@param name string
---@param opts table
---@returns nil
local set_hl = function(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

local set_tabline_custom_colors = function(colors)
	set_hl("MiniTablineModifiedHidden", { bg = colors.bg1, fg = colors.fg1 })
	set_hl("MiniTablineVisible", { bg = colors.bg1, fg = colors.fg1 })
	set_hl("MiniTablineCurrent", { bg = colors.bg2, fg = colors.green })
	set_hl("MiniTablineModifiedCurrent", { bg = colors.bg2, fg = colors.green })
end

local set_files_custom_colors = function(colors)
	set_hl("MiniFilesNormal", { bg = colors.bg2 })
	set_hl("MiniFilesBorder", { bg = colors.bg2 })
end

local set_notify_custom_colors = function(colors)
	set_hl("MiniNotifyNormal", { bg = colors.bg2 })
	set_hl("MiniNotifyBorder", { bg = colors.bg2 })
end

-- Used in mini.files to open the file in a vertical split
function map_split(buf_id, lhs, direction)
	local mini_files = require("mini.files")

	function rhs()
		local cur_target = mini_files.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. " split")
			return vim.api.nvim_get_current_win()
		end)

		mini_files.set_target_window(new_target)
	end

		local desc = "Split " .. direction
		vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

local add_modified_icon = function(buf_nr, label)
	local modified_icon = "●"
	local is_modified = vim.api.nvim_get_option_value("modified", {
		buf = buf_nr,
	})
	if is_modified then
		return require("mini.tabline").default_format(buf_nr, label) .. modified_icon .. " "
	else
		return require("mini.tabline").default_format(buf_nr, label)
	end
end

--- Places the notification window in the lower right corner, above the command line and status line (if present).
local notify_win_config = function()
	local has_statusline = vim.o.laststatus > 0
	local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
	return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
end

local plugins = {
	notify = {
		window = {
			config = notify_win_config,
		},
	},
	files = {
		windows = {
			preview = true,
			width_preview = 75,
		},
		options = {
			use_as_default_explorer = true,
		},
	},
	icons = {},
	pairs = {},
	tabline = {
		tabpage_section = "right",
		format = add_modified_icon,
	},
	bufremove = {},
	comment = {},
}

return {
	"nvim-mini/mini.nvim",
	event = "VeryLazy",
	config = function()
		local colors = require("gruvbox-material.colors").get(vim.o.background, "medium")

		set_tabline_custom_colors(colors)
		set_files_custom_colors(colors)
		set_notify_custom_colors(colors)

		for name, opts in pairs(plugins) do
			require("mini." .. name).setup(opts)
		end

    -- enable opening files in splits from mini.files
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				map_split(buf_id, "<C-s>", "belowright horizontal")
				map_split(buf_id, "<C-v>", "belowright vertical")
				map_split(buf_id, "<C-t>", "tab")
			end,
		})
	end,
}
