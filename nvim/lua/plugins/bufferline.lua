return {
	-- bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/edgy.nvim",
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				diagnostics_indicator = function(count, level, _, _)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			local Offset = require("bufferline.offset")
			if not Offset.edgy then
				local get = Offset.get
				Offset.get = function()
					if package.loaded.edgy then
						local layout = require("edgy.config").layout
						local ret = { left = "", left_size = 0, right = "", right_size = 0 }
						for _, pos in ipairs({ "left", "right" }) do
							local sb = layout[pos]
							if sb and #sb.wins > 0 then
								local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
								ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
								ret[pos .. "_size"] = sb.bounds.width
							end
						end
						ret.total_size = ret.left_size + ret.right_size
						if ret.total_size > 0 then
							return ret
						end
					end
					return get()
				end
				Offset.edgy = true
			end
		end,
	},
}
