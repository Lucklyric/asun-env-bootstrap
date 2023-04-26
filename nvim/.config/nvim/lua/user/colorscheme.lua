vim.cmd [[
try
  colorscheme tokyonight
  set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
if !has('gui_running')
  hi! Normal ctermbg=NONE guibg=NONE
endif
]]
