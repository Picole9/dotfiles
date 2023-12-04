return {
    -- file explorer as buffer
        {
            'stevearc/oil.nvim',
            dependencies = { "nvim-tree/nvim-web-devicons" },
            keys = {
                {"<F3>", "<cmd>lua require('oil').toggle_float()<cr>", desc="file explorer"},
            },
            opts = {
                use_default_keymaps = true,
                view_options = {
                    show_hidden = true,
                },
                float = {
                    -- Padding around the floating window
                    padding = 10,
                    max_width = 40,
                    max_height = 0,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    override = function(conf)
                        return conf
                    end,
              },
            },
        }
}
