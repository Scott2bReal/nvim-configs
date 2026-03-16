return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	---@module "ibl.config"
	---@type ibl.config
	opts = {
		scope = {
			enabled = false,
		},
	},
}
