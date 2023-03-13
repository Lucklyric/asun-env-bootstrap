vim.cmd [[
nnoremap <s-t>n :FloatermNew<CR>
tnoremap <s-t>n <C-\><C-n>:FloatermNew<CR>
nnoremap <s-t>h :FloatermPre<CR>
tnoremap <s-t>h <C-\><C-n>:FloatermPre<CR>
nnoremap <s-t>h :FloatermNext<CR>
tnoremap <s-t>l <C-\><C-n>:FloatermNext<CR>
nnoremap <s-t>t :FloatermToggle<CR>
tnoremap <s-t>t <C-\><C-n>:FloatermToggle<CR>
nnoremap <s-t>f :FloatermNew fzf<CR>
]]
