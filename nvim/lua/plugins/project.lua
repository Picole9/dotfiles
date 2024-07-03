return {
	"ahmedkhalf/project.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			opts = {
				extensions = {
					projects = {},
				},
			},
		},
	},
	opts = {
		-- manual_mode = true,
		detection_methods = { "pattern" },
	},
	keys = {
		{ "<leader>tp", "<cmd>Telescope projects<cr>", { desc = "[P]rojects" } },
	},
	event = "VeryLazy",
	config = function(_, opts)
		require("project_nvim").setup(opts)
		require("telescope").load_extension("projects")
	end,
}
