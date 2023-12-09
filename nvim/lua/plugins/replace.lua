return {
    -- easier search and replace
    {
        "roobert/search-replace.nvim",
        keys = {
            { "<leader>rs", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "[R]eplace and [s]earch" },
            { "<leader>rv", "<CMD>SearchReplaceWithinVisualSelection<CR>", mode = "v", desc = "[R]eplace and search [v]isual" },
        },
        opts = {
            default_replace_single_buffer_options = "gcI",
            default_replace_multi_buffer_options = "egcI",
        }
    }
}
