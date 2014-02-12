"
" DEPENDENCY
"   Vundle (git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle)
"       run ':BundleInstall' in vim or 'vim +BundleInstall +qall' in console


"------------------------------------------------------------
" SETTINGS

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Enable syntax highlighting
syntax on

" Syntax coloring too-long lines is slow
set synmaxcol=2048

" Character encoding
set encoding=utf-8

" Line numbers
set relativenumber
set number

" Show ruler (show line and column numbers)
set ruler

" Don't wrap text at the end of window
set nowrap

" Tabs
set tabstop=8
set expandtab
set shiftwidth=2
set softtabstop=2

" Enable List characters (visualise tabs, spaces, and line endings)
set list
set listchars=tab:\ \ ,trail:·,    " don't show tabs, show trailing spaces
" set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

" Case insensitive autocompletion of filename or directories
set wildignorecase

" show possible completions of commands, file names, etc. in the status line
set wildmenu

" allow backspacing (del) over everything in insert mode
set backspace=indent,eol,start

" Set region to British English
set spelllang=en_gb




"------------------------------------------------------------
" MAPPINGS

let mapleader = ","

" toggle paste mode (to keep indendation from copy-paste)
nmap <leader>p :setlocal paste! paste?<CR>

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>






"------------------------------------------------------------
" AUTOCOMMANDS



" Trim trailing whitespace
function TrimTrailingWhiteSpace()
  if &ft != 'markdown'
    %s/\s*$//
    ''
  endif
endfunction
autocmd FileWritePre * :call TrimTrailingWhiteSpace()
autocmd FileAppendPre * :call TrimTrailingWhiteSpace()
autocmd FilterWritePre * :call TrimTrailingWhiteSpace()
autocmd BufWritePre * :call TrimTrailingWhiteSpace()







"------------------------------------------------------------
" VUNDLE PLUGINS

filetype off

" set runtime path
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage Vundle
Bundle 'gmarik/vundle'


" wasabi colorscheme
Bundle 'thomd/vim-wasabi-colorscheme'
set t_Co=256
silent! color wasabi256


" airline - lean & mean status/tabline for vim that's light as air
Bundle 'bling/vim-airline'
let g:airline_left_sep=''
let g:airline_left_alt_sep='|'
let g:airline_right_sep=''
let g:airline_right_alt_sep='|'
let g:airline_theme='powerlineish'
"let g:airline#extensions#tabline#enabled = 1     " Automatically displays all buffers when there's only one tab open
set laststatus=2                                 " Always display the statusline in all windows
set noshowmode                                   " Hide the default mode text (e.g. -- INSERT -- below the statusline)

if ! has('gui_running')                          " immediateyy exit insert mode
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

"Bundle 'bling/vim-bufferline'


" Perform all your vim insert mode completions with Tab
Bundle 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"


" Implement some of TextMate's snippets features in Vim
Bundle 'msanders/snipmate.vim'


" Comments
Bundle 'scrooloose/nerdcommenter'


" Show a VCS diff using Vim's sign column
Bundle 'mhinz/vim-signify'


" Fuzzy file, buffer, mru, tag, etc finder
Bundle 'kien/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|precompiled$\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$\|.gitignore$'
  \ }


" Ultra-fast HTML coding
Bundle 'mattn/emmet-vim'


" True Sublime Text style multiple selections for Vim
Bundle 'terryma/vim-multiple-cursors'





" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on




