return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
                defaults = {
                    file_ignore_patterns = { '.git/' }
                },
                pickers = {
                    find_files = {
                        hidden = true
                    }
                }
        })

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")

        -- See `:help telescope.builtin`
        vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
        vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
        vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
        vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
        vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
        vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
    end
}
