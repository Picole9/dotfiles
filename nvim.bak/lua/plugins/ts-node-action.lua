return {
	-- A framework for running functions on Tree-sitter nodes, and updating the buffer with the result.
	{
		"ckolkey/ts-node-action",
		dependencies = { "nvim-treesitter" },
		opts = {},
		keys = {
			{ "<leader>n", "<cmd>lua require('ts-node-action').node_action()<cr>", desc = "[N]ode Action" },
		},
	},
}
