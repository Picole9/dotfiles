return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        { "<F3>", "<CMD>Neotree toggle<CR>", desc = "Neotree" },
    },
    opts = {
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            filtered_items = {
                hide_hidden = false,
                hide_dotfiles = false,
                hide_gitignored = false,
            }
        }
    }
}
