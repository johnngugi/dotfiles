-- Language Server Protocol
return {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'b0o/schemastore.nvim', {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = 'nvim-lua/plenary.nvim'
    }, 'jayp0521/mason-null-ls.nvim'},
    config = function()
        require('mason').setup({})
        require('mason-lspconfig').setup({
            automatic_installation = true
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- PHP
        require('lspconfig').intelephense.setup({
            capabilities = capabilities
        })

        -- Vue, JavaScript, TypeScript
        require('lspconfig').volar.setup({
            capabilities = capabilities
            -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        })

        require('lspconfig').tsserver.setup({
            -- capabilities = capabilities,
            init_options = {
                plugins = {{
                    name = "@vue/typescript-plugin",
                    location = "$NVM_BIN/../lib/node_modules/@vue/typescript-plugin",
                    languages = {"javascript", "typescript", "vue"}
                }}
            },
            filetypes = {"javascript", "typescript", "vue"}
        })

        -- Tailwind CSS
        require('lspconfig').tailwindcss.setup({
            capabilities = capabilities
        })

        -- JSON
        require('lspconfig').jsonls.setup({
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas()
                }
            }
        })

        -- Go
        require('lspconfig').gopls.setup({
            -- on_attach = on_attach
            capabilities = default_capabilities,
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    }
                }
            }
        })

        -- null-ls
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({'.eslintrc.js'})
                    end
                }),
                null_ls.builtins.diagnostics.trail_space.with({
                    disabled_filetypes = {'NvimTree'}
                }),
                null_ls.builtins.formatting.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({'.eslintrc.js', '.eslintrc.json'})
                    end
                }),
                null_ls.builtins.formatting.prettier.with({
                    condition = function(utils)
                        return utils.root_has_file({'.prettierrc', '.prettierrc.json', '.prettierrc.yml',
                                                    '.prettierrc.js', 'prettier.config.js'})
                    end
                }),
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                timeout_ms = 5000
                            })
                        end
                    })
                end
            end
        })

        require('mason-null-ls').setup({
            automatic_installation = true
        })

        -- Keymaps
        vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
        vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
        vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
        vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
        -- vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

        -- Goto Declaration
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
            desc = '[G]oto [D]eclaration'
        })

        -- Commands
        vim.api.nvim_create_user_command('Format', function()
            vim.lsp.buf.format({
                timeout_ms = 5000
            })
        end, {})

        -- Diagnostic configuration
        vim.diagnostic.config({
            -- virtual_text = false,
            float = {
                source = true
            }
        })
    end
}
