return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			icons_enabled = true,
			theme = "gruvbox-material",
			component_separators = { left = "/", right = "/" },
			section_separators = { left = "", right = "" },
			-- section_separators = { left = " ", right = " " },
			disabled_filetypes = { "alpha", "toggleterm" },
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				"filename",
			},
			lualine_x = { "encoding", "fileformat", "filetype" },
			-- lualine_y = { 'progress' },
			lualine_y = {},
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
	},
	config = function(_, opts)
		local has_lualine, lualine = pcall(require, "lualine")
		if not has_lualine then
			vim.notify("Lualine not found")
			return
		end

		local function append_right(component)
			table.insert(opts.sections.lualine_x, 1, component)
		end

		local function ins_y(component)
			table.insert(opts.sections.lualine_y, component)
		end

		-- cool function for progress
		-- credit chris@machine
		local progress = function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end

		append_right({
			-- Lsp server name
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
		})

		ins_y(progress)

		lualine.setup(opts)
	end,
}
