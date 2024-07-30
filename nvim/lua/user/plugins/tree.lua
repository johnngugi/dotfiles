return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            git = {
                ignore = false,
            },
            renderer = {
                group_empty = true,
                indent_markers = {
                    enable = true,
                },
            },
        })
    end,
}
