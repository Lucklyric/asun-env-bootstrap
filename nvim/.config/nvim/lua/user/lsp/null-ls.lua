local null_ls_status_ok, null_ls = pcall(require, "null-ls")
local diagnostic                 = require("vim.diagnostic")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = {},
			extra_filetypes = { "solidity" } }),
		formatting.yapf.with({ extra_args = { "--style", "google" } }),
		diagnostics.cspell.with({ disabled_filetypes = { "NvimTree", "alpha" },
					diagnostics_postprocess = function(diagnostics_)
						diagnostics_.severity = vim.diagnostic.severity.WARN
					end,
					}),
		code_actions.cspell.with({ disabled_filetypes = { "NvimTree", "alpha" } }),
		-- formatting.black.with({ extra_args = { "--fast"} }),
		-- formatting.stylua,
		-- diagnostics.flake8
		--[[ diagnostics.solhint, ]]
	},
	on_attach = function()
		vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]
	end
})


function toggle_cspell()
	require("null-ls").toggle(diagnostics.cspell)
end

toggle_cspell()
