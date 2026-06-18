return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                htmldjango = { "djlint" },
            },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "djlint",
            },
        },
    },
}
