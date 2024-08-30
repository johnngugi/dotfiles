return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{
			"<leader>Hl",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "[H]arpoon list",
		},
		{
			"<leader>Ha",
			function()
				require("harpoon"):list():add()
			end,
			desc = "[H]arpoon Add",
		},
		{
			"<leader>Hn",
			function()
				require("harpoon"):list():next()
			end,
			desc = "[H]arpoon Next",
		},
		{
			"<leader>Hp",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "[H]arpoon Previous",
		},
	},
}
