return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			yaml = { "prettier" },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
