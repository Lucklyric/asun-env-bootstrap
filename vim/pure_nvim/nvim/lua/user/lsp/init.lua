-- !! now i use coc.nvim to handle lsp

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
require "user.lsp.configs"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
require "user.lsp.saga"
require "user.lsp.lsp-signaure"
