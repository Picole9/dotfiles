return {
    -- lsp-config
    { -- lsp-config
        "neovim/nvim-lspconfig",
        dependencies = {
            -- lsp-manager
            { "williamboman/mason.nvim", opts = {} },
            -- server-configs
            "williamboman/mason-lspconfig.nvim",
            -- telescope integration
            'nvim-telescope/telescope.nvim',
            -- completion integration
            'hrsh7th/cmp-nvim-lsp',
            -- status updates for LSP
            { 'j-hui/fidget.nvim', opts = {} },
        },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                },
                html = {},
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "off"
                            }
                        }
                    }
                },
                marksman = {}, -- markdown
                bashls = {},
                tsserver = {}, -- javascript
                yamlls = {},
            },
        },
        config = function(_, opts)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            local lspconfig = require("lspconfig")
            local have_mason, mlsp = pcall(require, "mason-lspconfig")

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(opts.servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    server_opts.capabilities = capabilities
                    lspconfig[server].setup(server_opts)
                    ensure_installed[#ensure_installed + 1] = server
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed})
            end

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>gd', require('telescope.builtin').lsp_definitions, opts)
                    vim.keymap.set('n', '<leader>i', require('telescope.builtin').lsp_implementations, opts)
                    vim.keymap.set('n', '<leader>d', require('telescope.builtin').lsp_type_definitions, opts)
                    vim.keymap.set('n', '<leader>s', require('telescope.builtin').lsp_document_symbols, opts)
                    vim.keymap.set('n', '<leader>r', require('telescope.builtin').lsp_references, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>c', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
    },
}
