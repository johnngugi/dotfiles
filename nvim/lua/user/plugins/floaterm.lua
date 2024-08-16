--- Floating terminal

return {
  'voldikss/vim-floaterm',

  config = function()
    vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>')
    vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
    vim.g.floaterm_height = 0.4
    vim.g.floaterm_wintype = 'split'
  end
}
