-- Syntax highlighting

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'comment',
          'css',
          'diff',
          'git_config',
          'git_rebase',
          'gitattributes',
          'gitcommit',
          'gitignore',
          'go',
          'html',
          'http',
          'ini',
          'javascript',
          'json',
          'jsonc',
          'lua',
          'make',
          'markdown',
          'passwd',
          'php',
          'phpdoc',
          'python',
          'regex',
          'sql',
          'typescript',
          'vim',
          'vue',
          'xml',
          'yaml',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['if'] = '@function.inner',
              ['af'] = '@function.outer',
              ['ia'] = '@parameter.inner',
              ['aa'] = '@parameter.outer',
            },
          },
        },
        config = function(_, opts)
          require('nvim-treesitter.configs').setup(opts)
        end
    })
  end
}
