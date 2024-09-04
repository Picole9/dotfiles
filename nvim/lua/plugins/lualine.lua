return {
	-- statusbar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"stevearc/conform.nvim",
		},
		opts = {
			icons_enabled = true,
			sections = {
				lualine_c = {
					function()
						local clients
						clients = vim.lsp.get_active_clients()
						local clients_list = {}
						for _, client in pairs(clients) do
							table.insert(clients_list, client.name)
						end
						for _, formatter in pairs(require("conform").formatters_by_ft[vim.bo.filetype]) do
							table.insert(clients_list, formatter)
						end
						if #clients_list ~= 0 then
							return "󱉶 " .. table.concat(clients_list, ", ")
						end
					end,
				},
			},
		},
	},
}
