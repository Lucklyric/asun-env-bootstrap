local options = {
  backup = false,                                  -- creates a backup file
  clipboard = "unnamed",                           -- allows neovim to access the system clipboard
  -- clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                                   -- more space in the neovim command line for displaying messages
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                                -- so that `` is visible in markdown files
  fileencoding = "utf-8",                          -- the encoding written to a file
  hlsearch = true,                                 -- highlight all matches on previous search pattern
  ignorecase = true,                               -- ignore case in search patterns
  mouse = "a",                                     -- allow the mouse to be used in neovim
  pumheight = 10,                                  -- pop up menu height
  showmode = false,                                -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                                 -- always show tabs
  smartcase = true,                                -- smart case
  smartindent = true,                              -- make indenting smarter again
  splitbelow = true,                               -- force all horizontal splits to go below current window
  splitright = true,                               -- force all vertical splits to go to the right of current window
  swapfile = false,                                -- creates a swapfile
  termguicolors = true,                            -- set term gui colors (most terminals support this)
  timeoutlen = 400,                                -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                                 -- enable persistent undo
  undolevels = 10000,
  updatetime = 300,                                -- faster completion (4000ms default)
  writebackup = false,                             -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                                -- convert tabs to spaces
  shiftwidth = 2,                                  -- the number of spaces inserted for each indentation
  tabstop = 2,                                     -- insert 2 spaces for a tab
  cursorline = true,                               -- highlight the current line
  number = true,                                   -- set numbered lines
  relativenumber = true,                           -- set relative numbered lines
  numberwidth = 4,                                 -- set number column width to 2 {default 4}
  signcolumn = "yes",                              -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                                     -- display lines as one long line
  scrolloff = 8,                                   -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h12",                       -- the font used in graphical neovim applications
  laststatus = 3
}

vim.opt.shortmess:append "c"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

vim.cmd [[
  fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endfun
  command! TrimWhitespace call TrimWhitespace()
]]

vim.cmd [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
" if !has('gui_running')
"   hi! Normal ctermbg=NONE guibg=NONE
" endif
]]
