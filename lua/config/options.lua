local opts = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 1000,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes:1",
	wrap = false,
	scrolloff = 8,
	guifont = "",
	background = "dark",
	syntax = "enable",
	foldmethod = "marker",
	mousemodel = "extend",
	laststatus = 3,
	winborder = "rounded",
	showcmd = false,
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

-- Don't pass messages to |ins-completion-menu|. e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found", "Back at original"
vim.opt.shortmess:append("c")
-- Allow these keys to wrap
vim.cmd("set whichwrap+=<,>,[,],h,l")
-- Allow hyphenated words to be treated as a single word
vim.cmd([[set iskeyword+=-]])

-- Disable perl support checkhealth warning
vim.g.lodaded_perl_provider = 0

-- Tell vim to treat .h files as c
vim.g.c_syntax_for_h = 1
