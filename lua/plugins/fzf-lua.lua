return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
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
			profile = "ivy",
		},
		live_grep = {
			profile = "ivy",
		},
		previewers = {
			builtin = {
				syntax_limit_b = 100 * 1024, -- 100kb
			},
		},
	},
	---@diagnostic enable: missing-fields
}
