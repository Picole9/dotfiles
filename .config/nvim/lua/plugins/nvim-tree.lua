return {
    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { "<F3>", "<cmd>NvimTreeToggle<cr>", desc = "toggle file explorer" },
        opts = {},
	}
}
