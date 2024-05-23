return {
    { -- view markdown, requires glow as package
        "ellisonleao/glow.nvim",
        opts = {},
        cmd = "Glow"
    },
    { -- indent lines
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<leader>tr",
                "<CMD>Trouble<CR>",
                desc = "[tr]ouble"
            },
        },
        opts = {
        },
    },
}
