return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	-- Set up alpha dashboard
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                                      ]],
			[[                                      ]],
			[[   ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█ ]],
			[[    █  █▀   ▀  █   █      █  ██ █ █ █ ]],
			[[██   █ ██▄▄    █   █ █     █ ██ █ █ █ ]],
			[[█ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █ ]],
			[[█  █ █ ▀███▀           █  █   ▐    █  ]],
			[[█   ██                  █▐        ▀   ]],
			[[                        ▐             ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
			-- dashboard.button("o", "󰸊  Open Oil", ":Oil . <CR>"),
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			-- dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
			dashboard.button("r", "󱋡  Recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button("t", "󰍉  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("w", "  Vimwiki", ":VimwikiIndex<CR>"),
			-- dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
			dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
		}

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true
		return dashboard
	end,

	config = function(_, dashboard)
		local has_lazy, lazy = pcall(require, "lazy")
		if not has_lazy then
			vim.notify("Lazy.nvim is not installed", vim.log.levels.WARN)
			return
		end
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					lazy.show()
				end,
			})
		end

		require("alpha").setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = lazy.stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
