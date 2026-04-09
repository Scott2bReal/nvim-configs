vim.api.nvim_create_autocmd("UIEnter", {
	group = vim.api.nvim_create_augroup("_lualine-setup", { clear = true }),
	once = true,
	callback = function()
		local colors = require("rose-pine.palette")

		require("lualine").setup({
			options = {
				icons_enabled = true,
				component_separators = { left = "\\", right = "/" },
				-- section_separators = { left = "", right = "" },
				section_separators = { left = " ", right = "" },
				disabled_filetypes = { "ministarter" },
				always_divide_middle = true,
				globalstatus = true,
				theme = "rose-pine",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						function()
							local project_root_dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
							-- show path to current file starting at project root
							local file_path = vim.fn.expand("%:~:.")

							if file_path == "" then
								return project_root_dirname
							else
								-- Truncate the file path if it's too long
								local max_length = 40
								if #file_path > max_length then
									file_path = "..." .. string.sub(file_path, -max_length)
								end
								return project_root_dirname .. " > " .. string.gsub(file_path, "/", " > ")
							end
						end,
						color = { fg = colors.muted },
						cond = function()
							local ft = vim.bo.filetype
							local disabled_filetypes = { "minifiles", "help", "fzf", "lazy" }
							return not vim.tbl_contains(disabled_filetypes, ft)
						end,
					},
				},
				lualine_x = {
					{
						"lsp_status",
						icon = "",
						show_name = false,
						symbols = {
							separator = "",
						},
						color = { fg = colors.leaf },
					},
					{
						"fileformat",
						color = { fg = colors.iris },
					},
					{
						"filetype",
						color = { fg = colors.gold },
					},
				},
				lualine_y = {
					{
						function()
							local current_line = vim.fn.line(".")
							local total_lines = vim.fn.line("$")
							local chars =
								{ "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
							local line_ratio = current_line / total_lines
							local index = math.ceil(line_ratio * #chars)
							return chars[index]
						end,
						color = { fg = colors.foam },
					},
				},
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
})
