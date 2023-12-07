return {
    -- popup for keybindings
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
        config = function ()
            require('which-key').register {
                ['<leader>c'] = { name = '[C]omment', _ = 'which_key_ignore' },
                ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
                ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
                ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
            }
        end,
    }
}
