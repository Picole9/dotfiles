return {
    -- predefined windowlayouts
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.splitkeep = "screen"
        end,
        opts = {
            bottom = {
                {
                    ft = "lazyterm",
                    title = "Terminal",
                    size = { height = 0.4 },
                    filter = function(buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
                {
                    ft = "toggleterm",
                    title = "Terminal",
                    size = { height = 0.4 },
                },
                "Trouble",
                { ft = "qf", title = "Qickfix" },
                {
                    ft = "help",
                    size = { height = 20 },
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                }
            },
            left = {
                {
                    title = "Neo-Tree",
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "filesystem"
                    end,
                    size = { height = 0.5 },
                },
                {
                    ft = "tagbar",
                    title = "Tagbar",
                    size = { width = 30 },
                },
            },
            right = {
            },
        }
    },
}
