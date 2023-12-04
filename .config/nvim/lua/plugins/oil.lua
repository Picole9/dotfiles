return {
    -- file explorer as buffer
        {
            'stevearc/oil.nvim',
            dependencies = { "nvim-tree/nvim-web-devicons" },
            keys = {
                {"<F3>", "<cmd>30vsplit | Oil<cr>", desc="file explorer"},
            },
            opts = {
                use_default_keymaps = true,
                view_options = {
                    show_hidden = true,
                },
            },
        }
}
