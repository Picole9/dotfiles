return {
    -- better syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "dockerfile",
                "fish",
                "html",
                "javascript",
                "json",
                "lua",
                "python",
                "query",
                "vim",
                "vimdoc",
                "yaml",
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        },
    },
    -- autopair
    {
        'windwp/nvim-autopairs',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        event = "InsertEnter",
        opts = {
            check_ts = true
        }
    },
    -- Automatically add end keywords for Ruby, Lua, Python, and more
    "RRethy/nvim-treesitter-endwise",
    -- Autoclose and autorename HTML and Vue tags
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },

}
