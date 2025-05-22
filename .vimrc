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

" use highlighting when doing a search.
set hlsearch

" while searching though a file incrementally highlight matching characters as you type.
set incsearch

" ignore capital letters during search.  
set ignorecase

" override the ignorecase option if searching for capital letters.
" this will allow you to search specifically for capital letters.
set smartcase

" check my word spellings. Didnt know this existed!?
" thanks to this blog:https://danielmiessler.com/blog/vim
"set spell spelllang=en_us

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

" put swap,backup and undo files in a special location
" instead of the current working directory
" thanks https://stackoverflow.com/a/15317146/30236232
set backupdir=~/.vim/tmp/backups
set directory=~/.vim/tmp/swaps
set undodir=~/.vim/tmp/undo

" Automatically re-read the file if it has changed and not ask me every single time!!!
set autoread

" Disable showmode - i.e. Don't show mode texts like --INSERT-- in current statusline.
" set noshowmode -> turned off. vital on smaller screens

" set auto code folding
set foldmethod=indent
set foldmethod=syntax

" Conquer of Code(CoC) settings
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


"}}}


" 2.Key bindings ---------------------------------------------------------------- {{{

" set space as the map leader. And one to rule them all 
" ensure spacebar doesnt have mapping prior
nnoremap <Space> <Nop>
let mapleader = " "

" Read an empty HTML template and move cursor to title
" Learnt from https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
nnoremap <leader>! :-1read $HOME/.vim/.base.html<CR>6jwf>a

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

" navigate between windows easily by using:
" <leader>h,j,k or l
noremap <leader>h <c-w>h
noremap <leader>j <c-w>j
noremap <leader>k <c-w>k
noremap <leader>l <c-w>l

" close a window easily
noremap <leader>c <c-w>c

" moving an entire line up/down ->I use this alot!!
" ddkP -> move line up
noremap <leader><up> ddkP
" ddp -> move line down
noremap <leader><down> ddp

" open netrw quickly
" from this discussion: https://stackoverflow.com/a/51199145/30236232
map <silent> <leader>e :call ToggleVexplorer()<CR>


" }}}


" 3.Plugins -------------------------------------------------------------- {{{

call plug#begin()

  " track time spent coding
  Plug 'wakatime/vim-wakatime'

  " syntax highlighting for various languages
  Plug 'sheerun/vim-polyglot'

call plug#end()

"}}}


" 4.Themes/Colors -------------------------------------------------------------- {{{


" set term gui colors
set termguicolors

" use gruvbox dark theme. alternative is light theme
set background=dark

"}}}


" 5.Status Bar -------------------------------------------------------------- {{{

  " Clear status line when vimrc is reloaded.
  " Status line left side.
  set statusline=
  
  " custom colours for different sections of status line
  hi User1 ctermbg=black ctermfg=grey guibg=black guifg=grey
  hi User2 ctermbg=green ctermfg=black guibg=green guifg=black
  hi User3 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen
  
  " which mode that you are currently in
  " the extra " "s are for spacing
  set statusline+=%*\ " "
  set statusline+=%*\%{StatuslineMode()}
  set statusline+=%*\ " "
  
  " show git branch
  set statusline+=%3*\ " "
  set statusline+=%3*\<<\%{StatuslineGit()}>>
  set statusline+=%3*\ " "
  
  " t -> the filename
  " m -> modified flag text, either [+] or [-]
  set statusline+=%*\%3*\ %t\ %m
  
  " Use a divider to separate the left side from the right side.
  set statusline+=%=
  
  " y -> type of file
  " ff -> file encoding
  " r -> if file is read only 
  set statusline+=%1*\ " "
  set statusline+=%1*\ %y\ %r\ LOC:\ %l/%L\ %p%%\ %*
  set statusline+=%1*\ " "
  
  " Status line right side
  set statusline+=%*\ " "
  set statusline+=%*\ buffer:[%n]\ %*
  set statusline+=%*\ " "
  
  " Show the status on the second to last line.
  set laststatus=2

"}}}


" 5.Vimscript -------------------------------------------------------------- {{{ 

" MODIFY NETWR
"modify netrw
" From this stackoverflow dicussion: https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
" remove list characters
autocmd FileType netrw set nolist

" do not display info on the top of window
" i actually like the info displayed!
" let g:netrw_banner = 0

" do not re-use directory listings
let g:netrw_fastbrowse = 0 

" keep current directory same as browsing directory
let g:netrw_keepdir = 0

" preview pane split vertically not horizontally
let g:netrw_preview = 1

" absolute width of window with netwr present
let g:netrw_winsize = 25

" tree-view
let g:netrw_liststyle = 3  

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" hide dotfiles
let g:netrw_list_hide = ',\(^\|\s\s\)\zs\.\S\+'

" hide dotfiles by default. toggle with gh
let g:netrw_hide = 1 

" use the previous window to open file
let g:netrw_browse_split = 4

" clear netrw buffers after youre done with them  
augroup netrw
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup end

"close netrw if only remaining buffer
autocmd WinEnter * if winnr('$') == 1
  \ && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"
  \ || &buftype == 'quickfix' | q | endif

" Toggle Vexplore with Ctrl-O
function! ToggleVexplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      let cur_win_num = winnr()

      if expl_win_num != -1
          while expl_win_num != cur_win_num
              exec "wincmd w"
              let cur_win_num = winnr()
          endwhile

          close
      endif

      unlet t:expl_buf_num
  else
       Vexplore
       let t:expl_buf_num = bufnr("%")
  endif
endfunction

" custom statusline functions
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
    rlseif l:mode==#"R"
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


" This will enable code folding.
" Use the marker method of folding.
" only in this specific .vimrc file
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
" TODO: look for the equivalent of this in NeoVim.
if version >= 703
  set undodir=~/.vim/backup
  set undofile
  set undoreload=10000
endif

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

