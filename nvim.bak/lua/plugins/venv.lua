return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
		"mfussenegger/nvim-dap-python",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	branch = "regexp",
	cmd = "VenvSelect",
	opts = {},
	keys = { { "<leader>tv", "<cmd>:VenvSelect<cr>", desc = "[V]irtualEnv select", ft = "python" } },
}
