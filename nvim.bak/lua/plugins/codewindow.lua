return {
    -- code minimap
    {
        'gorbit99/codewindow.nvim',
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup()
            vim.keymap.set('n', '<F4>', ':lua require("codewindow").toggle_minimap()<cr>', { desc = "toggle minimap" })
        end,
    }
}
