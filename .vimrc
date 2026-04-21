"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filename: .vimrc                                               "
" description: edit text at the speed of thought!                "
" sections:                                                      "
"     1.options...................general vim behaviour          "
"     2.key bindings..............custom key mappings            "
"     3.vimscript.................code supporting functions above"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 1.options ------------------------------------------------------------------------- {{{

"be iMproved always!
set nocompatible

" show line numbers from current cursor position
set number
set relativenumber

" use the monokai theme. no brainer
syntax on
filetype plugin on
filetype indent plugin on
set termguicolors
" unokai -> monokai	retrobox->gruvbox
" sorbet -> dracula	zaibatsu -> tokyo night
colorscheme unokai

" split go to the right/below always
set splitright                          " cursor remain on left window
set splitbelow                          " cursor remain on top window

" netrw optimizations
let g:netrw_banner = 0                  " do not display info on the top of window
let g:netrw_keepdir = 0                 " keep current directory same as browsing directory
let g:netrw_winsize = 25                " absolute width of window with netwr present
let g:netrw_fastbrowse = 0              " do not re-use directory listings
let g:netrw_preview = 1                 " preview pane split vertically not horizontally
let g:netrw_liststyle = 3               " tree-view
let g:netrw_hide = 1                    " hide dotfiles by default. toggle with gh
let g:netrw_browse_split = 4            " use the current window to open new file
let g:netrw_localcopydircmd = 'cp -r'   " allow recursive copying of directories

" remove automatic backing up of files; already in VCS
set nobackup
set nowb
set noswapfile

"}}}


" 2.key bindings--------------------------------------------------------------------- {{{

" map leader to space
nnoremap <Space> <Nop>
let mapleader = " "

" add some mods to match nvim
map <leader>w :w<CR>			" save file content
map <leader>c <C-w>c<CR>		" close a window
map <leader>so :noh<CR>		        " stop search highlight
map <leader>\ :vsplit<CR>		" vertical split
map <leader>- :split<CR>		" horizontal split

" netrw from this discussion: https://stackoverflow.com/a/51199145/30236232
map <silent> <leader>e :call ToggleNetrw()<CR>

" navigate between recent buffers
noremap <leader>n :bnext<CR>
noremap <leader>p :bprevious<CR>

" insert automatic closing and opening brackets,parens,quotation marks
" to escape them use ctrl+v before typing mapped command
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" }}}


" 3.vimscript------------------------------------------------------------------------ {{{

" remove list characters
autocmd FileType netrw set nolist

" clear netrw buffers after youre done with them
augroup netrw
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
augroup end

" close vim if only remaining buffer is netrw
autocmd WinEnter * if winnr('$') == 1
  \ && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"
  \ || &buftype == 'quickfix' | q | endif

" Toggle netrw with<leader>e
function! ToggleNetrw()
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

" enable code folding using the marker method in this specific .vimrc file
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

"}}}
