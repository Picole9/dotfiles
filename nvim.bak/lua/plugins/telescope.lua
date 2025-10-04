return {
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			-- which key integration
			{
				"folke/which-key.nvim",
				optional = true,
				opts = {
					defaults = {
						{ "<leader>t", group = "[T]elecope" },
					},
				},
			},
		},
		opts = {
			extensions = {
				undo = {},
			},
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>tg", "<cmd>Telescope git_files<cr>", desc = "[G]it files" },
			{ "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "search [F]iles" },
			{ "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "[H]elp tags" },
			{ "<leader>ts", "<cmd>Telescope grep_string<cr>", desc = "grep [S]tring" },
			{ "<leader>tl", "<cmd>Telescope live_grep<cr>", desc = "[L]ive grep" },
			{ "<leader>td", "<cmd>Telescope diagnostics<cr>", desc = "[D]iagnostics" },
			{ "<leader>tr", "<cmd>Telescope resume<cr>", desc = "[R]esume" },
			{ "<leader>tk", "<cmd>Telescope keymaps<cr>", desc = "[K]eymaps" },
			{ "<leader>tu", "<cmd>Telescope undo<cr>", desc = "[U]ndo tree" },
		},
		config = function()
			require("telescope").load_extension("undo")
		end,
	},
}
