return {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "client", "screen", "root", "vim" },
				disable = { "lowercase-global", "trailing-space" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					-- vim.api.nvim_get_runtime_file("", true),
          vim.env.VIMRUNTIME,
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
				},
			},
		},
	},
}

