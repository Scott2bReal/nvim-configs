-- Don't start the next new line with a comment
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("_comment_settings", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})

-- Use just q to close some special buffers
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("_general_settings", { clear = true }),
	pattern = { "help", "man", "lspinfo", "checkhealth", "qf", "nvim-pack" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
	end,
})

-- Equalize window dimensions when resizing the Vim window
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("_auto_resize", { clear = true }),
	pattern = "*",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Restore the default cursor shape when leaving Neovim
vim.api.nvim_create_autocmd("VimLeave", {
	group = vim.api.nvim_create_augroup("_shape", { clear = true }),
	callback = function()
		vim.opt.guicursor = "a:hor10-blinkwait150-blinkoff150-blinkon150"
	end,
})

-- Allow tmux to show native terminal progress indicator
vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local value = ev.data.params.value or {}
		if not value.kind then
			return
		end

		local status = value.kind == "end" and 0 or 1
		local percent = value.percentage or 0

		local osc_seq = string.format("\27]9;4;%d;%d\a", status, percent)

		if os.getenv("TMUX") then
			osc_seq = string.format("\27Ptmux;\27%s\27\\", osc_seq)
		end

		io.stdout:write(osc_seq)
		io.stdout:flush()
	end,
})
