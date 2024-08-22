-- Automatically set the working directory to the project root.

return {
  'airblade/vim-rooter',
  init = function()
    -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
    vim.g.rooter_manual_only = 1
    vim.g.rooter_patterns = { '.git' }
    vim.g.rooter_change_directory_for_non_project_files = "current"
  end,
  config = function()
    vim.cmd 'Rooter'
  end,
}
