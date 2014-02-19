
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
"
" Spacing and tabbing
" Use shiftwidth and tabstop smartly
set smarttab

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

" opening a new file when the current buffer has unsaved changes causes files
" to be hidden instead of closed
set hidden

" Skip backup entirely
set nobackup
if has("writebackup")
  set nowritebackup
endif

" Auto indent new lines
set autoindent

" Show matching braces
set showmatch

" max width of a column
set textwidth=100

" Don't wrap text
set nowrap

" Highlight the first column after the text width
"set colorcolumn=+1
call matchadd('ColorColumn', '\%81v', 100)

" Split windows below and right -- default is above and left
set splitbelow
set splitright

" Highlight searches
set hlsearch

" Be smart about searching case-sensitively
set smartcase
set ignorecase

" Search as you type
set incsearch

" Wrap around the file when searching
set wrapscan

" Turn swap off
set noswapfile
set updatecount=0

" Better redrawing for large files
set ttyfast

" Disable the vbell
set visualbell t_vb=

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" max changes that can be undone
set undolevels=1000

" max lines to save for undo on buffer reload
set undoreload=10000

" Respect vim modelines
set modeline

" Highlight the line the cursor is on
set cursorline

" Always display the statusline in all windows
set laststatus=2

" Height of the command bar
set cmdheight=2

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

" Set to auto read when a file is changed from the outside
set autoread

" Enable use of the mouse for all modes
set mouse=a

" changes the 'w' small word motion not to stop at dashes
set iskeyword+=-



"------------------------------------------------------------
" MAPPINGS

let mapleader = ","

" toggle paste mode (to keep indendation from copy-paste)
nmap <silent> <leader>p :setlocal paste! paste?<CR>

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" toggle increment search (search as you type)
nnoremap <leader>i :set incsearch!<CR>

" remove highlighted search results
nnoremap <leader>h :nohlsearch<CR>
nnoremap <silent> <C-l> :nohl<CR><C-l>

" save file without root privileges (when you forgot to sudo before editing a file)
cmap w!! w !sudo tee % >/dev/null

" open markdown files in Marked.app
map <Leader>md :!open -a /Applications/Marked.app/ %<CR><CR>

" swap v and CTRL-V, because block mode is more useful that visual mode
nnoremap v <C-V>
nnoremap <C-V> v
vnoremap v <C-V>
vnoremap <C-V> v

" list buffers
nnoremap <silent> <leader><leader> :BuffergatorOpen<CR>

" show vim undo tree
nnoremap U :GundoToggle<CR>

" git
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gs :Git status -sb<cr>

" toggle NERDTree
map <silent> <leader>n :NERDTreeToggle<cr>

" move lines
nnoremap - :m .+1<CR>==
nnoremap _ :m .-2<CR>==
vnoremap - :m '>+1<CR>gv=gv
vnoremap _ :m '<-2<CR>gv=gv

" Shift + left/right to switch tabs.
" You may need to map these in iTerm2 prefs to escape
" sequences [1;2C (right) and D (left).
noremap <S-Left> :tabp<CR>
noremap <S-Right> :tabn<CR>



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


" immediately exit insert mode (conflicts with emmet-vim)
"if ! has('gui_running')
  "set ttimeoutlen=10
  "augroup FastEscape
    "autocmd!
    "au InsertEnter * set timeoutlen=0
    "au InsertLeave * set timeoutlen=1000
  "augroup END
"endif


" tab/space for filetypes
au FileType xhtml,xml,html set textwidth=0
au FileType make set noexpandtab shiftwidth=8
au FileType python set expandtab shiftwidth=4 softtabstop=4 tabstop=4 autoindent
au FileType javascript set tabstop=4 shiftwidth=4 expandtab textwidth=100

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" format xml files (http://ku1ik.com/formatting-xml-in-vim-with-indent-command)
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" enable xml syntax folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax




"------------------------------------------------------------
" VUNDLE PLUGINS

filetype off

" install vundle is missing
if !isdirectory(expand("~/.vim/bundle/vundle/.git"))
  !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
endif

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
let g:airline_theme='powerlineish'

" Automatically displays all buffers when there's only one tab open
"let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep=''
let g:airline_left_alt_sep='|'
let g:airline_right_sep=''
let g:airline_right_alt_sep='|'
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.branch = '⎇'
let g:airline_symbols.readonly = '⭤'             " default: 'RO'
let g:airline_symbols.linenr = '⭡'

" Add a red '*' for modified buffers
function! AirlineInit()
  call airline#parts#define_raw('modified', '%{&modified ? " *" : ""}')
  call airline#parts#define_accent('modified', 'orange')
  let g:airline_section_c = airline#section#create(['%f', 'modified'])
endfunction
autocmd VimEnter * call AirlineInit()


" The ultimate snippet solution for Vim
Bundle 'SirVer/ultisnips'


" Changes Vim working directory to project root
" (identified by presence of known directory or file)
Bundle 'airblade/vim-rooter'


" Comments
Bundle 'scrooloose/nerdcommenter'


" Show a VCS diff using Vim's sign column
Bundle 'mhinz/vim-signify'


" Fuzzy file, buffer, mru, tag, etc finder
Bundle 'kien/ctrlp.vim'
let g:ctrlp_map='<c-p>'
let g:ctrlp_show_hidden=1
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_use_caching=0
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$\|precompiled$\|tmp$',
      \ 'file': '\.exe$\|\.so$\|\.dat$\|.gitignore$'
      \ }


" Ultra-fast HTML coding
Bundle 'mattn/emmet-vim'


" True Sublime Text style multiple selections for Vim
Bundle 'terryma/vim-multiple-cursors'


" play framework
Bundle 'thomd/vim-play-framework'


" Surround.vim is about surroundings: parentheses, brackets, quotes, XML and tags
Bundle 'tpope/vim-surround'


" A tree explorer plugin
Bundle 'scrooloose/nerdtree'
let NERDTreeQuitOnOpen=1
let NERDTreeMinimalUI=1
let NERDTreeWinSize=50
let NERDTreeDirArrows=1
let NERDTreeShowBookmarks=1
" automatically load NERDTree if vim is started without arguments
"function! StartUp()
    "if !exists("s:std_in") && 0 == argc()
        "NERDTree
    "end
"endfunction
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * call StartUp()


" automatic closing of quotes, parenthesis, brackets, etc.
Bundle 'Raimondi/delimitMate'


" git support
Bundle 'tpope/vim-fugitive'
let g:airline_section_b = '%{airline#extensions#branch#get_head()}'


" Vim plugin to list, select and switch between buffers
Bundle 'jeetsukumaran/vim-buffergator'
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_split_size = '10'
let g:buffergator_sort_regime = 'mru'
let g:airline#extensions#bufferline#enabled = 0


" HTML5
Bundle 'othree/html5.vim'


" ack in vim
Bundle 'ack.vim'
" Skip normal config, show filenames, no color, one result per line, show column numbers, smart case
let g:ackprg="ack --noenv -H --nocolor --nogroup --column --smart-case --after=0 --before=0"


" Zoom in/out of windows (toggle between one window and multi-window)
Bundle 'ZoomWin'


" visualize your Vim undo tree
Bundle 'sjl/gundo.vim'
let g:gundo_preview_bottom=1
let g:gundo_close_on_revert=1


" Better Rainbow Parentheses
Bundle 'kien/rainbow_parentheses.vim'


" bats support (bash testing framework)
Bundle 'rosstimson/bats.vim'


" Make scrolling in Vim more pleasant
Bundle 'terryma/vim-smooth-scroll'


" Toggle the cursor shape in the terminal for Vim
"Bundle 'jszakmeister/vim-togglecursor'


" Fold away lines not matching the last search pattern
Bundle 'vim-scripts/searchfold.vim'


" LessCSS Syntax support in Vim
Bundle 'groenewege/vim-less'


" Perform all your vim insert mode completions with Tab
Bundle 'ervandew/supertab'
"let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
"let g:SuperTabDefaultCompletionType='context'
"let g:SuperTabNoCompleteAfter
let g:SuperTabDefaultCompletionType = 'context'


" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on




