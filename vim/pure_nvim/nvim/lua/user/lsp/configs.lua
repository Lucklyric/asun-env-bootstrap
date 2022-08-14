local status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end
local util = require 'lspconfig.util'

local configs = require("lspconfig.configs")
local lspconfig = require("lspconfig")
local nlspsettings = require("nlspsettings")

nlspsettings.setup({
	local_settings_dir = ".nlsp-settings",
	append_default_schemas = true,
	loader = 'json'
})


local servers = {
	"jsonls",
	"sumneko_lua",
	"omnisharp",
	"cadence",
	"tsserver",
	"jedi_language_server",
	"jdtls",
	"taplo",
	"rust_analyzer"
}

-- cadence
if not configs.cadence then
	configs.cadence = {
		default_config = {
			cmd = { 'flow', 'cadence', 'language-server', '--enable-flow-client=false' },
			root_dir = util.root_pattern('flow.json'),
			filetypes = { 'cadence' },
		}
	}
end

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		if server == "pyright" then
			print(vim.inspect(server_custom_opts))
		end
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end

	if server == "jdtls" then goto continue end

	if server == "rust_analyzer" then
		require("rust-tools").setup({
			server = {
				on_attach = require("user.lsp.handlers").on_attach,
				capabilities = require("user.lsp.handlers").capabilities,
			}
		})
		goto continue
	end

	lspconfig[server].setup(opts)

	::continue::
end
