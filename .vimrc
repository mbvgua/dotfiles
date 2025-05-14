"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Filename: .vimrc                                               "
"Sections:                                                      "   
"    1.General...................general vim behaviour          "
"    2.Plugins...................installed plugins              "
"    3.Key bindings..............custom aliases                 "
"    4.Themes/Colors.............colors,fonts,icons e.t.c       "
"    5.Layout....................tab,side panel, task bar e.t.c "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 1.General --------------------------------------------------------- {{{

"be iMproved always! could cause unexpected issues if compatible to vi
set nocompatible

" enable type file detection. it detects the type of file in use
filetype on

" enable plugins and load plugin for the detected file type.
filetype plugin on
  
" load an indent file for the detected file type.
filetype indent on

" turn on syntax highlighting
syntax on

" show line numbers
set number

"show line number from current cursor position
set relativenumber

" minimal number of lines to keep above and below cursor
set scrolloff=7

" minimal number of lines to keep on left/right of cursor
set sidescrolloff=8 

" split go below always
set splitbelow

" vertical split to the right always
set splitright

" wrap long lines
set wrap
set linebreak
" set textwidth=80 -> hard wrapping. not good with VCS, and other editors
set wrapmargin=0

" use highlighting when doing a search.
set hlsearch

" while searching though a file incrementally highlight matching characters as you type.
set incsearch

" ignore capital letters during search.  
set ignorecase

" override the ignorecase option if searching for capital letters.
" this will allow you to search specifically for capital letters.
set smartcase

" show partial command you type in the last line of the screen.
set showcmd

" show matching words during a search.  
set showmatch 

" Set the commands to save in history default number is 20.
set history=200

" enable auto completion menu after pressing TAB key
set wildmenu

" make wildmenu behave similar to Bash completion
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" navigate between buffers without saving changes
set hidden

" switch NERDTree position from left to right
let g:NERDTreeWinPos = "right"

" put swap,backup and undo files in a special location
" instead of the current working directory
" thanks https://stackoverflow.com/a/15317146/30236232
set backupdir=~/.vim/backup
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Automatically re-read the file if it has changed and not ask me every single time!!!
set autoread

" Disable showmode - i.e. Don't show mode texts like --INSERT-- in current statusline.
" set noshowmode -> turned off. vital on smaller screens

" set auto code folding
set foldmethod=indent
set foldmethod=syntax

" ignore the node_modules dir always
let g:NERDTreeIgnore = ['^node_modules$']

" insert automatic closing and opening brackets,parens,quotation marks
" to escape them use ctrl+v before typing mapped command
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Read an empty HTML template and move cursor to title
" Learnt from https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
nnoremap <leader>! :-1read $HOME/.vim/.base.html<CR>6jwf>a

" Conquer of Code(CoC) settings
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
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
inoremap <silent><expr> <leader>, coc#refresh()

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

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
    call CocActionAsync('doHover')
  endif
endfunction

"}}}


" 2.Key bindings ---------------------------------------------------------------- {{{

" set space as the map leader. And one to rule them all 
" ensure spacebar doesnt have mapping prior
nnoremap <Space> <Nop>
let mapleader = " "

" focus NERDtree buffer from any window
nnoremap <leader>f :NERDTreeFocus<CR>

" show/hide{toogle} NERDTree
nnoremap <leader>s :NERDTreeToggle<CR>

" navigate between windows easily by using:
" <leader>h,j,k or l
noremap <leader>h <c-w>h
noremap <leader>j <c-w>j
noremap <leader>k <c-w>k
noremap <leader>l <c-w>l

" close a window easily
noremap <leader>c <c-w>c

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>">"
noremap <c-right> <c-w>"<"

" moving an entire line up/down ->I use this alot!!
" ddkP -> move line up
noremap <leader><up> ddkP
" ddp -> move line down
noremap <leader><down> ddp

" }}}


" 3.Plugins -------------------------------------------------------------- {{{

call plug#begin()

  " track time spent coding
  Plug 'wakatime/vim-wakatime'

  " syntax highlighting for various languages
  Plug 'sheerun/vim-polyglot'

  " nerdtree as a better sidebar navigation tool
  Plug 'preservim/nerdtree'|
            \ Plug 'Xuyuanp/nerdtree-git-plugin'

  " have a stylish tabline/statusline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " lol. installed only so vim airline could work!
  Plug 'tpope/vim-fugitive'

  " auto completion. mostly for frontend gymnastics
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"}}}


" 4.Themes/Colors -------------------------------------------------------------- {{{

" set term gui colors
set termguicolors

" CoC Colur scheme
" Use a consistent background color for Coc floating windows
hi CocFloating ctermbg=DarkGrey

" Use a consistent foreground color for Coc error messages
hi CocErrorFloat ctermfg=LightRed

" Link the Coc floating window to your theme's default background
autocmd VimEnter,colorscheme * hi link CocFloating Normal

" use the molokai color scheme
colorscheme molokai

" looks like sublime -> jackpot!
let g:molokai_original = 1

"}}}


" 5.Status Bar -------------------------------------------------------------- {{{

" customize airline sections
" show tabline alongside status line .from airline
let g:airline#extensions#tabline#enabled = 1

" show relative path in tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline_filetype_overrides = {
    \ 'coc-explorer':  [ 'CoC Explorer', '' ],
    \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
    \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
    \ 'floggraph':  [ 'Flog', '%{get(b:, "flog_status_summary", "")}' ],
    \ 'gundo': [ 'Gundo', '' ],
    \ 'help':  [ 'Help', '%f' ],
    \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
    \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERDTree'), '' ],
    \ 'startify': [ 'startify', '' ],
    \ 'vim-plug': [ 'Plugins', '' ],
    \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
    \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
    \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
    \ }

" set the list of fav airline themes
" wombat,distinguished, minimalist
let g:airline_theme='wombat'

" disable autofilling of sections to allow customization
let g:airline_skip_empty_sections = 1

" customize sections of airline statusline
" %m -> show modified status
" %r -> show read only section
" %w -> show preview window flag
" get these values by :help 'statusline'
" make the last warning section blank. Finally! 
let g:airline_section_c = '%m%r%w'
let g:airline_section_z = airline#section#create(['LOC:%l/%L percentage: %p%%'])
let g:airline_section_warning = ''

"}}}


" 5.Vimscript -------------------------------------------------------------- {{{ 

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" NERDtree functions
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif

" auto reload NERDTree when there is a change in directory(e.delete,add files)
autocmd BufEnter NERD_tree_* | execute 'normal R'
au CursorHold * if exists("t:NerdTreeBufName") | call <SNR>15_refreshRoot() | endif

" autorefresh for change in current working directory
augroup DIRCHANGE
  au!
  autocmd DirChanged global :NERDTreeCWD
augroup END

" automatically quit from nerdtree if its only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
  set undodir=~/.vim/backup
  set undofile
  set undoreload=10000
endif

" airline custom symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.notexists = ' ∄'

" " powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='📝'

" set auto tab spacing for python files
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" set tab spacing for other langs
au BufNewFile,BufRead *.ts, *.js, *.html, *.css,
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" }}}
