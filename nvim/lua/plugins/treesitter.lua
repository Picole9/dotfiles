return {
	-- better syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"dockerfile",
				"diff",
				"fish",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- autopair
	{
		"windwp/nvim-autopairs",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
	},
}
