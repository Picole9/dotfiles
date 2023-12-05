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
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function ()
            vim.opt.splitkeep = "screen"
        end,
        opts = {
            bottom = {
                {
                    ft = "lazyterm",
                    title = "Terminal",
                    size = { height = 0.4 },
                    filter = function (buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
                { ft = "qf", title = "Qickfix" },
                {
                    ft = "help",
                    size = { height = 20 },
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                }
            },
        }
    },
}
