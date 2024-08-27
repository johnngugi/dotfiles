--- Floating terminal

return {
	"voldikss/vim-floaterm",
	keys = {
		{ "<F1>", ":FloatermToggle<CR>", desc = "Floaterm toggle (n)" },
		{ "<F1>", "<Esc>:FloatermToggle<CR>", mode = "i", desc = "Floaterm toggle (i)" },
		{ "<F1>", "<C-\\><C-n>:FloatermToggle<CR>", mode = "t", desc = "Floaterm toggle (t)" },
	},
	cmd = { "FloatermToggle" },
	init = function()
		-- vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.4
		vim.g.floaterm_wintype = "split"
		-- Windows
		-- vim.g.floaterm_shell = 'pwsh'
	end,
}
