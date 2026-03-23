local M = {}

M.setup = function()
	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
end

local function lsp_keymaps(bufnr)
	local DEFAULT_OPTS = { noremap = true, silent = true, nowait = true }

	local set_keymap = function(mode, lhs, rhs, custom_opts)
		custom_opts = vim.tbl_extend("force", DEFAULT_OPTS, custom_opts or {})
		return vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, custom_opts)
	end

	set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	set_keymap("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>')
	set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" or client.name == "ts_ls" then
		client.server_capabilities.document_formatting = false
		-- client.server_capabilities.semanticTokensProvider = nil
	end

	if client.name == "jsonls" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "astro" then
		client.server_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
	M.capabilities = blink.get_lsp_capabilities(capabilities)
else
	M.capabilities = capabilities
end

return M
