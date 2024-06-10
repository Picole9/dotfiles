return {
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			-- which key integration
			{
				"folke/which-key.nvim",
				optional = true,
				opts = {
					defaults = {
						["<leader>t"] = { name = "[T]elecope" },
					},
				},
			},
		},
		opts = {
			extensions = {
				undo = {},
			},
		},
		config = function()
			require("telescope").load_extension("undo")
			vim.keymap.set("n", "<leader>tg", require("telescope.builtin").git_files, { desc = "[G]it files" })
			vim.keymap.set("n", "<leader>tf", require("telescope.builtin").find_files, { desc = "search [F]iles" })
			vim.keymap.set("n", "<leader>th", require("telescope.builtin").help_tags, { desc = "[H]elp tags" })
			vim.keymap.set("n", "<leader>ts", require("telescope.builtin").grep_string, { desc = "grep [S]tring" })
			vim.keymap.set("n", "<leader>tl", require("telescope.builtin").live_grep, { desc = "[L]ive grep" })
			vim.keymap.set("n", "<leader>td", require("telescope.builtin").diagnostics, { desc = "[D]iagnostics" })
			vim.keymap.set("n", "<leader>tr", require("telescope.builtin").resume, { desc = "[R]esume" })
			vim.keymap.set("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "[K]eymaps" })
			vim.keymap.set("n", "<leader>tu", "<cmd>Telescope undo<cr>", { desc = "[U]ndo tree" })
		end,
	},
}
