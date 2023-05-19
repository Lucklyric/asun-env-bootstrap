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
	local_settings_root_markers_fallback = { '.git' },
	append_default_schemas = true,
	loader = 'json'
})


local servers = {
	"jsonls",
	"lua_ls",
	"omnisharp_mono",
	"tsserver",
	--[[ "jedi_language_server", ]]
	--[[ "pyright", ]]
	"pylsp",
	"jdtls",
	"taplo",
	"rust_analyzer",
	"gopls",
	"cadence",
	"move_analyzer",
	"solidity_hardhat",
}

lsp_installer.setup({
	--[[ ensure_installed = servers, ]]
})


local custom_configs = {}
-- append custom serviers
--[[ for _, server in ipairs(custom_servers) do ]]
--[[ 	table.insert(servers, server) ]]
--[[ end ]]

configs.solidity_hardhat = {
	default_config = {
		cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
		filetypes = { 'solidity' },
		root_dir = lspconfig.util.find_git_ancestor,
		single_file_support = true,
	}
}


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

	-- if server in custom_configs then use custom config
	if custom_configs[server] then
		opts.default_config = custom_configs.default_config
	end

	lspconfig[server].setup(opts)

	::continue::
end
