return {
	-- file explorer as buffer
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 160,
				max_height = 40,
				preview_split = "auto",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{
				"<F3>",
				function()
					-- require("oil").toggle_float()
					-- SOURCE : https://github.com/stevearc/oil.nvim/issues/657
					if vim.w.is_oil_win then
						require("oil").close()
					else
						require("oil").open_float(nil, { preview = {} })
					end
				end,
				desc = "Oil file explorer",
			},
		},
	},
}
