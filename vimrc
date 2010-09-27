" VIM Configuration - Thomas Duerr
" based on http://0xfe.blogspot.com/2010/04/my-vim-configuration.html

" Enable syntax highlighting.
syntax on

" Colorscheme (http://blog.infinitered.com/entries/show/8)
colorscheme ir_black

" Do awesome stuff on MacVim
if has("gui_macvim")
  " Disable toolbar on MacVim
  set go-=T

  " MacVim font and color scheme
  set guifont=Inconsolata:h13
  colorscheme ir_black
endif

" Enable spell checking. For source code, it only checks comments.
" set spell spelllang=en_us

" Set title on X window
set title

" Hide buffer instead of abandoning when unloading
set hidden ruler wmnu

" Set GUI font and options
" set guifont=Monospace 8
" set guioptions=agimrLt
" set imi=0

" light-on-dark terminal
set background=dark

" Live incremental search
set incsearch

" Highlight current line (Vim 7)
set cursorline

" Tabs and indentation. Yes, I like 2-space tabs.
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
filetype indent on

" Allow extended digraphs
set encoding=utf-8

" Show status line (help statusline)
set statusline=%<%2*%f%h%1*%m%2*%r%h%w%y\ %*%{&ff}\ %=\ col:%c%V\ asc:%B\ pos:%o\ lin:%l\,%L\ %P
set laststatus=2

" Set status line colors
highlight ModeMsg cterm=bold ctermfg=cyan ctermbg=black
highlight StatusLine cterm=bold ctermfg=brown ctermbg=blue
highlight StatusLineNC cterm=bold ctermfg=black ctermbg=green

" Filename in white.
highlight User2 cterm=bold ctermfg=gray ctermbg=blue

" Modified flag on statusline.
highlight User1 ctermfg=red ctermbg=blue

" Highlight trailing whitespace and tab characters. Note that the foreground
" colors are overridden here, so this only works with the "set list" settings
" below.
" autocmd ColorScheme * highlight ExtraWhitespace ctermfg=red guifg=red
" highlight ExtraWhitespace ctermfg=red guifg=red cterm=bold gui=bold
" match ExtraWhitespace /\s\+$\|\t/

" Show tabs and trailing spaces.
" Ctrl-K >> for »
" Ctrl-K .M for ·
" Ctrk-K 0M for ●
" Ctrk-K sB for ▪
" (use :dig for list of digraphs)
" set list listchars=tab:»»,trail:·

" shortcuts
iab xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
iab xname Thomas Duerr <me@thomd.net>

" Strip trailing whitespace in whole file
func! StripTrailingWS()
  %s/\s\+$//
endfunc
command! StripTrailingWS call StripTrailingWS()
