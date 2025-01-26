return {
	-- file explorer as buffer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			default_file_explorer = true,
			use_default_keymaps = true,
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 80,
				max_height = 40,
				preview_split = "right",
			},
			vim.keymap.set(
				"n",
				"<leader><F3>",
				"<cmd>lua require('oil').toggle_float()<cr>",
				{ desc = "file explorer" }
			),
		},
	},
}
