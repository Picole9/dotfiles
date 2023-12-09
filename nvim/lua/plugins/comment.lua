return {
    -- comments
    {
        'numToStr/Comment.nvim', opts = {
            toggler = {
                ---Line-comment toggle keymap
                line = 'cll',
                ---Block-comment toggle keymap
                block = 'cbb',
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = 'cl',
                ---Block-comment keymap
                block = 'cb',
            },
            ---LHS of extra mappings
            extra = {
                ---Add comment on the line above
                above = 'clO',
                ---Add comment on the line below
                below = 'clo',
                ---Add comment at the end of line
                eol = 'clA',
            },
        },
    },
    -- comment-highlight for todo, hack, warn, parf, note, test, fix
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
    },

}
