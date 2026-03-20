return {
	"ibhagwan/fzf-lua",
	---@module "fzf-lua"
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {
		{ "telescope" },
		defaults = {
			file_icons = "mini",
		},
		files = {
			cwd_prompt = false,
		},
		oldfiles = {
			cwd_prompt = false,
			include_current_session = true,
		},
		helptags = {
			theme = "ivy",
		},
		live_grep = {
			theme = "ivy",
		},
		previewers = {
			builtin = {
				syntax_limit_b = 100 * 1024, -- 100kb
			},
		},
	},
	---@diagnostic enable: missing-fields
}
