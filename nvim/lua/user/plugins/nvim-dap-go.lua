-- go debugger

return {
  "leoluz/nvim-dap-go",
  dependencies = {
    "mfussenegger/nvim-dap"
  },
  config = function(_, opts)
    require('dap-go').setup(opts)

    vim.keymap.set('n', '<Leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Add a breakpoint at line' })
  end
}

