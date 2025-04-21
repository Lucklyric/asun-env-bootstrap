return {
	{
		"tamago324/nlsp-settings.nvim",
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = {
			diagnostics = {
				on_insert = false,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim", "tamago324/nlsp-settings.nvim", "nvimdev/lspsaga.nvim" },
		opts = function()
			local ret = {}

			--- diagnostics
			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
			}
			local diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "",
				},
				serverity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
				signs = {
					active = signs,
				},
			}
			ret.diagnostics = diagnostics

			local function lsp_keymaps(bufnr)
				local keymap = vim.keymap.set
				local opts = { noremap = true, silent = true, buffer = bufnr }
				keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				keymap("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
				keymap("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
				keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
				keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
				vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = ture})' ]])

				-- Rewrite if saga is installed
				local status_ok, _ = pcall(require, "lspsaga")
				if status_ok then
					-- Lsp finder find the symbol definition implement reference
					-- if there is no implement it will hide
					-- when you use action in finder like open vsplit then you can
					-- use <C-t> to jump back
					keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

					-- Code action
					keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

					-- Rename
					keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

					-- Peek Definition
					-- you can edit the definition file in this flaotwindow
					-- also support open/vsplit/etc operation check definition_action_keys
					-- support tagstack C-t jump back
					keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

					-- Show line diagnostics
					keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

					-- Show cursor diagnostic
					keymap(
						"n",
						"<leader>cd",
						"<cmd>Lspsaga show_cursor_diagnostics<CR>",
						{ silent = true, noremap = true }
					)

					-- Diagnsotic jump can use `<c-o>` to jump back
					keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
					keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

					-- Only jump to error
					keymap("n", "[E", function()
						require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
					end, { silent = true })
					keymap("n", "]E", function()
						require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
					end, { silent = true })

					-- Outline
					keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

					-- Hover Doc
					keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

					-- Callhierarchy
					keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
					keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
				end
			end
			ret.on_attach = function(client, bufnr)
				vim.notify(client.name .. " starting...")
				lsp_keymaps(bufnr)
			end

			ret.servers = {
				jsonls = {
					opts = require("plugins.lspopts.jsonls"),
				},
				lua_ls = {
					opts = {
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.stdpath("config") .. "/lua"] = true,
									},
								},
							},
						},
					},
					on_attach = function()
						vim.notify("Test on attach")
					end,
				},
				ts_ls = {},
				--[[ "jedi_language_server", ]]
				--[[ "pyright", ]]
				pyright = {},
				ruff = {},
				pylsp = {},
				taplo = {},
				rust_analyzer = {},
				gopls = {},
				--[[ "cadence", ]]
				solidity_ls_nomicfoundation = {},
				move_analyzer = {
					opts = {
						cmd = { "move-analyzer" }, -- Update the path accordingly
						filetypes = { "move" },
					},
					on_attach = function(client, bufnr)
						vim.notify("Move language server attached!")
					end,
				},
			}
			return ret
		end,

		config = function(_, opts)
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			-- Setup
			local nlspsettings = require("nlspsettings")
			nlspsettings.setup({
				local_settings_dir = ".nlsp-settings",
				local_settings_root_markers_fallback = { ".git" },
				append_default_schemas = true,
				loader = "json",
			})

			-- Setup Mason
			mason.setup()
			mason_lspconfig.setup()

			-- Setup diagnostics
			vim.diagnostic.config(opts.diagnostics)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			-- Setup capabilities
			local _, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Setup servers
			for server, server_config in pairs(opts.servers) do
				local local_opts = {
					on_attach = opts.on_attach,
					capabilities = capabilities,
				}
				if server_config.opts then
					local_opts = vim.tbl_deep_extend("force", local_opts, server_config.opts)
				end

				if server_config.on_attach then
					-- extend on_attach
					local_opts.on_attach = function(client, bufnr)
						opts.on_attach(client, bufnr)
						server_config.on_attach(client, bufnr)
					end
				end
				lspconfig[server].setup(local_opts)
			end
		end,
	},
}
