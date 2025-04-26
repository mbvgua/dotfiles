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

" do not wrap long lines. allow them to extend
set nowrap

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
    \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
    \ 'startify': [ 'startify', '' ],
    \ 'vim-plug': [ 'Plugins', '' ],
    \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
    \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
    \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
    \ }

"}}}


" 2.Key bindings ---------------------------------------------------------------- {{{

" And one to rule them all 
" set space as the map leader
" ensure spacebar doesnt have mapping prior
nnoremap <Space> <Nop>
let mapleader = " "

" move to NERDtree buffer from any window
nnoremap <leader>f :NERDTreeFocus<CR>

" show/hide{toogle} NERDTree
nnoremap <leader>s :NERDTreeToggle<CR>

" " create new vertical windows from NERTree with -
" nnoremap - :NERDTree
" " create new horizontal windows from NERTree with |
" nnoremap | :NERDTree

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

"modify netrw
" From this stackoverflow dicussion: https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
autocmd FileType netrw set nolist           " remove list characters
let g:netrw_preview = 1                     " preview pane split vertically not horizntally
let g:netrw_winsize = -28                    " absolute width of window with netwr present
let g:netrw_banner = 0                      " do not display info on the top of window
let g:netrw_liststyle = 3                   " tree-view
let g:netrw_sort_sequence = '[\/]$,*'       " sort is affecting only: directories on the top, files below
let g:netrw_browse_split = 4                " use the previous window to open file
autocmd filetype netrw nmap <c-a> <cr>:wincmd W<cr>     " Open file, but keep focus in Explorer

" }}}


" 3.Plugins -------------------------------------------------------------- {{{

call plug#begin()

  " track time spent coding
  Plug 'wakatime/vim-wakatime'

  " syntax highlighting for various languages
  Plug 'sheerun/vim-polyglot'

  " nerdtree as a better sidebar navigation tool
  Plug 'preservim/nerdtree'

  " manage tabs and buffers elegantly at the top
  " Plug 'bagrat/vim-buffet' -> APPARENTLY NOT THE VIM WAY

  " have a stylish tabline/statusline
  Plug 'vim-airline/vim-airline'

  " lol. installed only so vim airline could work!
  Plug 'tpope/vim-fugitive'

call plug#end()

"}}}


" 4.Themes/Colors -------------------------------------------------------------- {{{

" use the molokai color scheme
colorscheme molokai

" looks like sublime -> jackpot!
let g:molokai_original = 1

" looks like VsCode -> L
" let g:rehash256 = 1    

"}}}


" 5.Status Bar -------------------------------------------------------------- {{{

" INSTALLED AIRLINE TO REPLACE THIS
" can see how it looks with :AirlineToggle
" Clear status line when vimrc is reloaded.
" Status line left side.
set statusline=

" custom colours for different sections of status line
hi User1 ctermbg=black ctermfg=grey guibg=black guifg=grey
hi User2 ctermbg=green ctermfg=black guibg=green guifg=black
hi User3 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen

" which mode that you are currently in
" the extra " "s are for spacing
set statusline+=%2*\ " "
set statusline+=%2*\%{StatuslineMode()}
set statusline+=%2*\ " "

" show git branch
set statusline+=%3*\ " "
set statusline+=%3*\<<
set statusline+=%3*\%{StatuslineGit()} 
set statusline+=%3*\>>
set statusline+=%3*\ " "

" t -> the filename
" m -> modified flag text, either [+] or [-]
set statusline+=%*\%3*\ %t\ %m


" return to default color scheme
set statusline+=%*

" Use a divider to separate the left side from the right side.
set statusline+=%=

" y -> type of file
" ff -> file encoding
" r -> if file is read only 
set statusline+=%1*\ " "
set statusline+=%1*\ %y\ %{&ff}\ %r\ LOC:\ %l/%L\ %p%%\ %*
set statusline+=%1*\ " "

" Status line right side
set statusline+=%*\ " "
set statusline+=%*\ buffer:[%n]\ %*
set statusline+=%*\ " "

" Show the status on the second to last line.
set laststatus=2

" * mode         displays the current mode
" 4 * iminsert     displays the current insert method
" 3 * paste        displays the paste indicator
" 2 * crypt        displays the crypted indicator
" 1 * spell        displays the spell indicator
" 1922 * filetype     displays the file type
" 1 * readonly     displays the read only indicator
" 2 * file         displays the filename and modified indicator
" 3 * path         displays the filename (absolute path) and modifier indicator
" 4 * linenr       displays the current line number
" 5 * maxlinenr    displays the number of lines in the buffer
" 6 * ffenc        displays the file format and encoding

" customize airline sections to match my custom ones
" let g:airline_section_c = airline#section#create(['%f'])
let g:airline_section_z = airline#section#create(['LOC:%l/%L percentage: %p%%'])

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

" " auto reload NERDTree when there is a change in directory(e.delete,add files)
" autocmd BufEnter NERD_tree_* | execute 'normal R'
" au CursorHold * if exists("t:NerdTreeBufName") | call <SNR>15_refreshRoot() | endif

" autorefresh for change in current working directory
augroup DIRCHANGE
  au!
  autocmd DirChanged global :NERDTreeCWD
augroup END

" automatically quit from nerdtree if its only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" statusline functions
" get the Vim Mode you are in
function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
      return "NORMAL"
  elseif l:mode==?"v"
      return "VISUAL"
  elseif l:mode==#"i"
      return "INSERT"
  elseif l:mode==#"R"
      return "REPLACE"
  endif
endfunction

" get the git branch you are in
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' '.l:branchname.' ':''
endfunction

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
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

" add window number on statusline
function! WindowNumber(...)
  let builder = a:1
  let context = a:2
  call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
  return 0
endfunction

call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')


" }}}
