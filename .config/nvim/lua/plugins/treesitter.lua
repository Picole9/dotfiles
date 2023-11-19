return {
    -- better syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opt = {
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
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        },
    }
}
