local utils = require("utils")
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			icons_enabled = true,
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
				},
			},
			lualine_x = {
				"encoding",
				"fileformat",
				"filetype",
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = utils.colors.orange },
				},
			},
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
				local buf_ft = vim.api.nvim_get_option_value("filetype", {
					buf = 0,
				})
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					-- Lua LSP doesn't know about the filetypes field on the config table, but it's there!
					---@class vim.lsp.ClientConfig
					---@field filetypes string[] | nil
					local client_config = client.config
					local filetypes = client_config.filetypes
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
