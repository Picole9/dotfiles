return {
	-- easier search and replace
	{
		"roobert/search-replace.nvim",
		dependencies = {
			-- which key integration
			{
				"folke/which-key.nvim",
				optional = true,
				opts = {
					defaults = {
						{ "<leader>r", group = "[R]eplace" },
					},
				},
			},
		},
		keys = {
			{ "<leader>rs", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "[R]eplace" },
			{
				"<leader>rv",
				"<CMD>SearchReplaceWithinVisualSelection<CR>",
				mode = "v",
				desc = "[R]eplace and search [v]isual",
			},
		},
		opts = {
			default_replace_single_buffer_options = "gcI",
			default_replace_multi_buffer_options = "egcI",
		},
	},
}
