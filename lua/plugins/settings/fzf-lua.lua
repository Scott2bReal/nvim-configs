vim.api.nvim_create_autocmd("UIEnter", {
	group = vim.api.nvim_create_augroup("_fzf-lua-setup", { clear = true }),
	once = true,
	callback = function()
		require("fzf-lua").setup({
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
			---@diagnostic disable: missing-fields
			previewers = {
				builtin = {
					syntax_limit_b = 100 * 1024, -- 100kb
				},
			},
			---@diagnostic enable: missing-fields
		})
	end,
})
