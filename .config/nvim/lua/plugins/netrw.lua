return {
    -- enhanced netrw
    {
        'prichrd/netrw.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function ()
            -- netrw
            function ToggleNetrw()
                if vim.g.NetrwIsOpen then
                    local i = vim.fn.bufnr "$"
                    while i >= 1 do
                        if vim.fn.getbufvar(i, "&filetype") == "netrw" then
                            vim.cmd("bwipeout" .. i)
                            break
                        end
                        i = i -1
                    end
                    vim.g. NetrwIsOpen = false
                else
                    vim.g.NetrwIsOpen = true
                    vim.cmd [[silent Lexplore]]
                end
            end
            -- vim.keymap.set("n", "<F3>", ":Lexplore<CR>")
            -- vim.g.netrw_liststyle = 3 -- tree-style
            vim.g.netrw_winsize = 25 -- 25% of window
        end
    }
}
