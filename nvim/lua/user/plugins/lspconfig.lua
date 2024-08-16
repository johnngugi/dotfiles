-- Language Server Protocol

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    { 'jose-elias-alvarez/null-ls.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    'jayp0521/mason-null-ls.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({ automatic_installation = true })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- PHP
    require('lspconfig').intelephense.setup({ capabilities = capabilities })

    -- Vue, JavaScript, TypeScript
    require('lspconfig').volar.setup({
        capabilities = capabilities,
        -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    })

    require('lspconfig').tsserver.setup({
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "$NVM_BIN/../lib/node_modules/@vue/typescript-plugin",
              languages = {"javascript", "typescript", "vue"},
            },
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
    })

-- You must make sure volar is setup
-- e.g. require'lspconfig'.volar.setup{}
-- See volar's section for more information

    -- Tailwind CSS
    require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

    -- JSON
    require('lspconfig').jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
    })
  
    -- null-ls
    require('null-ls').setup({
        sources = {
          require('null-ls').builtins.diagnostics.eslint_d.with({
              condition = function(utils)
                return utils.root_has_file({ '.eslintrc.js' })
              end,
          }),
          require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
          require('null-ls').builtins.formatting.eslint_d.with({
              condition = function(utils)
                return utils.root_has_file({ '.eslintrc.js' })
              end,
          }),
          require('null-ls').builtins.formatting.prettierd,
        },
      })

    require('mason-null-ls').setup({ automatic_installation = true })

    -- Keymaps
    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
    -- vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
    vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
    -- vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    -- Commands
    vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, {})

    -- Diagnostic configuration
    vim.diagnostic.config({
       -- virtual_text = false,
       float = {
         source = true,
       }
    })
  end
}
