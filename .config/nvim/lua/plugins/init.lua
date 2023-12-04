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
    { -- comment for todo, hack, warn, parf, note, test, fix
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
}
