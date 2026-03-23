local utils = require("utils")

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

local show_dotfiles = false

local filter_show = function()
	return true
end

local filter_hide = function(fs_entry)
	return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
	show_dotfiles = not show_dotfiles
	local new_filter = show_dotfiles and filter_show or filter_hide
	MiniFiles.refresh({ content = { filter = new_filter } })
end

return (function()
	utils.set_hl("MiniFilesBorder", { bg = utils.colors.bg2 })
	utils.set_hl("MiniFilesNormal", { bg = utils.colors.bg2 })

	-- enable opening files in splits
	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			map_split(buf_id, "<C-s>", "belowright horizontal")
			map_split(buf_id, "<C-v>", "belowright vertical")
			map_split(buf_id, "<C-t>", "tab")
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			-- Tweak left-hand side of mapping to your liking
			vim.keymap.set("n", "H", toggle_dotfiles, { buffer = buf_id })
		end,
	})

	return {
		windows = {
			preview = true,
			width_preview = 75,
		},
		options = {
			use_as_default_explorer = true,
		},
    content = {
      filter = show_dotfiles and filter_show or filter_hide,
    }
	}
end)()
