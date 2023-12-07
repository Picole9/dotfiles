return {
    -- theme
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            vim.cmd([[
                colorscheme gruvbox
                hi Normal guibg=NONE ctermbg=NONE
            ]])
        end,

    }
}
