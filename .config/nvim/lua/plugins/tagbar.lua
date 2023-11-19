return {
    -- tagbar
    -- vim -> lua?
    {
        'preservim/tagbar',
        config = function ()
            vim.keymap.set('n', '<F2>', '<cmd>TagbarToggle<cr>')
        end
    }
}
