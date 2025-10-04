return {
	-- lsp-config
	{ -- lsp-config
		"neovim/nvim-lspconfig",
		dependencies = {
			{ -- lsp-manager
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
				opts = {
					ensure_installed = {
						"ansible-lint",
						"prettier",
						"shfmt",
						"stylua",
					},
				},
				config = function(_, opts)
					require("mason").setup(opts)
					local mr = require("mason-registry")
					local function ensure_installed()
						for _, tool in ipairs(opts.ensure_installed) do
							local p = mr.get_package(tool)
							if not p:is_installed() then
								p:install()
							end
						end
					end
					if mr.refresh() then
						mr.refresh(ensure_installed)
					else
						ensure_installed()
					end
				end,
			},
			-- server-configs
			"williamboman/mason-lspconfig.nvim",
			-- telescope integration
			"nvim-telescope/telescope.nvim",
			-- completion integration
			"hrsh7th/cmp-nvim-lsp",
			-- status updates for LSP
			{ "j-hui/fidget.nvim", opts = {} },
		},
		opts = {
			servers = {
				ansiblels = {},
				bashls = {},
				dockerls = {},
				--[[ fish_lsp = {}, ]]
				html = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							telemetry = { enable = false },
						},
					},
				},
				marksman = {}, -- markdown
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								ignore = { "*" },
							},
						},
					},
				},
				ruff = {
					settings = { args = {} },
				},
				ts_ls = {}, -- javascript
				yamlls = {},
			},
		},
		config = function(_, opts)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local lspconfig = require("lspconfig")
			local have_mason, mlsp = pcall(require, "mason-lspconfig")

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(opts.servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					server_opts.capabilities = capabilities
					lspconfig[server].setup(server_opts)
					if server_opts.enabled ~= false then
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
			end

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set(
						"n",
						"<C-k>",
						vim.lsp.buf.signature_help,
						{ desc = "buf.signature", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>tD",
						require("telescope.builtin").lsp_definitions,
						{ desc = "lsp_definitions", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>ti",
						require("telescope.builtin").lsp_implementations,
						{ desc = "lsp_implementations", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>tt",
						require("telescope.builtin").lsp_type_definitions,
						{ desc = "lsp_type_definitions", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>tS",
						require("telescope.builtin").lsp_document_symbols,
						{ desc = "lsp_document_symbols", buffer = ev.buf }
					)
					vim.keymap.set(
						"n",
						"<leader>tR",
						require("telescope.builtin").lsp_references,
						{ desc = "lsp_references", buffer = ev.buf }
					)
					vim.keymap.set(
						{ "n", "v" },
						"<leader>c",
						vim.lsp.buf.code_action,
						{ desc = "[C]ode action", buffer = ev.buf }
					)
				end,
			})
		end,
	},
}
