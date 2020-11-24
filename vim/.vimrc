" File  : .vimrc
" Author: Alvin(Xinyao) Sun <xinyao1@ualberta.ca>
" Date  : 01.11.2018

" Terminal Color
" RGB rgb(255,168,251)
" Hex ffa8fb
"
" Automatic reloading of .vimrc
set encoding=UTF-8
autocmd! bufwritepost .vimrc source %
set t_Co=256
set rnu
if (has("termguicolors"))
    set termguicolors
endif
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set nocompatible              " be iMproved, required

filetype off                  " required
filetype plugin on
" specify a directory for plugins

" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim diretomasiser/vim-code-darkctory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'Chiel92/vim-autoformat'
Plug 'Raimondi/delimitMate'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tenfyzhong/CompleteParameter.vim'
Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'
Plug 'Lucklyric/vim-header'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'severin-lemaignan/vim-minimap'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'voldikss/vim-floaterm'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'Yggdroot/indentLine'
Plug 'pseewald/vim-anyfold'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'roryokane/detectindent'
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vim-which-key'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'sheerun/vim-polyglot'

" - Front end
" Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
" Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }


" debuger
Plug 'puremourning/vimspector'
" initialize plugin system
call plug#end()
filetype plugin indent on    " required

let g:vim_jsx_pretty_colorful_config = 1 " default 0

" Own Setting
set autoindent
set cindent
set expandtab
set laststatus=2
set mouse+=a
if !has('nvim')
    if has("mouse_sgr")
        set ttymouse=sgr
    else 
        set ttymouse=xterm2
    endif
endif
set shiftwidth=2
set softtabstop=4
set tabstop=4
syntax on
noremap <F3> :Autoformat<CR>
let mapleader = ","
" set clipboard=unnamedplus
set clipboard=unnamed
set wildmenu
" set wildmode=longest,list,full
set colorcolumn=80
set undodir=~/.vim/undodir
set undofile
set incsearch

" CtrpP but with ag
noremap <c-p> :Ag<CR>

" Better copy & paste
set pastetoggle=<F2>
noremap  <leader><c-y> "+y
noremap  <leader><c-p> "+p

" Fold related
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Window movement
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Moving between tabs
nmap <leader>n :tabprevious<CR>
nmap <leader>m :tabnext<CR>


" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" map sort function to a key
vnoremap <leader>s :sort<CR>

" Usefull settings
set history=700
set undolevels=700
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set nu
set cursorline
set cursorcolumn


" Disable stupid backup
set nobackup
set nowritebackup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
"""  Custom functions
""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle spell check
let g:spell_is_close = 1
function! ToggleSpell()
    if g:spell_is_close
        setlocal spell spelllang=en_us
        let g:spell_is_close = 0
    else
        setlocal nospell
        let g:spell_is_close = 1
    endif
endfunction

nmap <leader>sp :call ToggleSpell()<CR>

" Check dirs
function! EnsureDirExists (dir)
    if !isdirectory(a:dir)
        if exists("*mkdir")
            call mkdir(a:dir,'p')
            echo "Created directory: " . a:dir
        else
            echo "Please create directory: " . a:dir
        endif
    endif
endfunction

augroup DetectIndent
   autocmd!
   autocmd BufReadPost *  DetectIndent
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" which key 
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader> :WhichKey ','<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
"""  UndoTree
""""""""""""""""""""""""""""""""""""""""""""""""""""
call EnsureDirExists($HOME . '/.vim/undodir')
nnoremap <leader>ud :UndotreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
"""  Latex Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats='pdf,bib,pdf,pdf'
let g:Tex_ViewRule_pdf = 'evince'
let g:vimtex_view_general_viewer = 'evince'


""""""""""""""""""""""""
" Plugin Configuration
"
""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
"""  Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>bb :BufExplorer<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
"""  Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>TT :TagbarToggle<CR>
let g:tagbar_autofocus=1

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
"""  Float Terminal VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <s-t>n :FloatermNew<CR>
tnoremap <s-t>n <C-\><C-n>:FloatermNew<CR>
nnoremap <s-t>h :FloatermPre<CR>
tnoremap <s-t>h <C-\><C-n>:FloatermPre<CR>
nnoremap <s-t>h :FloatermNext<CR>
tnoremap <s-t>l <C-\><C-n>:FloatermNext<CR>
nnoremap <s-t>t :FloatermToggle<CR>
tnoremap <s-t>t <C-\><C-n>:FloatermToggle<CR>

nnoremap <s-t>f :FloatermNew fzf<CR>


""YouCompleteMe configuration
" noremap <leader>jd :YcmCompleter GoTo<CR>
" let g:ycm_filetype_whitelist = {'c':1,'cpp':1,'cuda':1}
" let g:ycm_confirm_extra_conf=0
" set completeopt=longest,menu
" let g:ycm_min_num_of_chars_for_completion=2
" " let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_cache_omnifunc=0
" let g:ycm_complete_in_strings = 1
" let g:ycm_add_preview_to_completeopt=1
" let g:ycm_show_diagnostics_ui = 1
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" highlight Pmenu ctermbg=black ctermfg=white

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERD Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree configuration
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | NERDTree | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.pyc$', '\~$', 'node_modules'] "ignore files in

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERD Comment
""""""""""""""""""""""""""""""""""""""""""""""""""""
" add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' },'python':{'left':'#'} }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

""" Parameter Complete
" set cmdheight=2
" set noshowmode
" let g:complete_parameter_echo_signature = 1
" inoremap <silent><expr> ( complete_parameter#pre_complete("()")
" smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
" smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Auto Header
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:header_field_author = 'Alvin(Xinyao) Sun'
let g:header_field_author_email = 'xinyao1@ualberta.ca'
let g:header_auto_add_header = 0
let g:header_field_modified_timestamp = 0
let g:header_field_modified_by = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Formater
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:formatdef_yapf = "'yapf --style=\"{based_on_style=google,spaces_before_comment=4,indent_width:4,column_limit:160}\"'"
let g:formatters_python=['yapf']


""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Any-Fold
""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on
autocmd Filetype * AnyFoldActivate
let g:anyfold_fold_comments=1
set foldlevel=0

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Snips
""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Latex setting

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Color Theme Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='fruit_punch'
let g:airline#extensions#tabline#enabled = 1
set background=dark
colorscheme palenight
" colorscheme codedark
" let g:palenight_terminal_italics=1
" let g:hybrid_transparent_background = 1
if !has('gui_running')
  hi! Normal ctermbg=NONE guibg=NONE
endif
highlight MatchParen ctermbg=blue guibg=lightblue

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
""" COC Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = ['coc-json',
            \'coc-tsserver', 
            \'coc-python', 
            \'coc-css', 
            \'coc-html', 
            \'coc-emmet', 
            \'coc-prettier', 
            \'coc-eslint', 
            \'coc-java', 
            \'coc-git',
            \'coc-prettier', 
            \'coc-snippets', 
            \'coc-yank', 
            \'https://github.com/SvenBecker/vscode-pytorch', 
            \'https://github.com/xabikos/vscode-react', 
            \'coc-marketplace',
            \'coc-json',
            \]


""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Coc Base Default from https://github.com/neoclide/coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=yes
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Coc Base END
""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNew,BufEnter *.c,*.cpp,*.cu execute "silent! CocDisable"
autocmd BufLeave *.c,*.cpp,*.cu execute "silent! CocEnable"

map <silent> zs :for id in synstack(line("."), col("."))<bar>
            \ echo synIDattr(id, "name").' '<bar> execute 'echohl' synIDattr(synIDtrans(id), "name") <bar> echon synIDattr(synIDtrans(id), "name") <bar> echohl None <bar>
            \ endfor<CR>

" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
