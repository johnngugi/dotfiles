return {
	"akinsho/flutter-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	opts = {
		dev_log = {
			enabled = true,
			open_cmd = "vsplit",
		},
	},
}
