local pid = vim.fn.getpid()
local omnisharp_bin = "/home/asun/.local/share/nvim/lsp_servers/omnisharp/omnisharp/OmniSharp"
return {
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
}
