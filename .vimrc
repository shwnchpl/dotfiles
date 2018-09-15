" File: _vimrc
" Version: 1
" Author: Shawn M. Chapla
" Created: 10 Oct 2016 20:35:00

" Last-modified: 10 Aug 2018 10:02:00

" Vundle stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" Share clipboard with MacOS
" set clipboard=unnamed

" Normal backspacing.
set backspace=indent,eol,start

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" Mathematica syntax highlighting
" Plugin 'rsmenon/vim-mathematica'

" vim-markdown plugin
" Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'

" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_fenced_languages = ['mathematica=mma']

" Rust syntax highlighting etc.
" Plugin 'rust-lang/rust.vim'

" Don't use recommended style overrides
" let g:rust_recommended_style = 0

" nerdtree source tree view plugin
"Plugin 'scrooloose/nerdtree'

" CtrlP fuzzy find
"Plugin 'kien/ctrlp.vim'

" Required for Vim Gist plugin
"Plugin 'mattn/webapi-vim'

" Vim Gist plugin
"Plugin 'mattn/gist-vim' 

" All of your Plugins must be added before the following line
"call vundle#end()            " required
filetype plugin indent on    " required

" Global configurations
set number
set hlsearch
set title
syntax enable
filetype on

if exists('krnl_src_fmt')
  set tabstop=8
  set softtabstop=8
  set shiftwidth=8
  set noexpandtab

  set colorcolumn=81
  highlight ColorColum ctermbg=Black ctermfg=DarkRed
else
  " Regular configuration
  set expandtab

  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set textwidth=0
endif

" Add mathematica syntax highlighting for .mma and .wl files.
" au BufNewFile,BufRead *.mma set filetype=mma
" au BufNewFile,BufRead *.wl set filetype=mma

" Press Space to turn off highlighting and clear any messages already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Make all trailing whitespace characters and tabs visible.
set list listchars=tab:»\ ,trail:#,extends:»,precedes:«

" Fast buffer movement.
execute "set <M-;>=\033;"
execute "set <M-1>=\0331"
execute "set <M-2>=\0332"
execute "set <M-3>=\0333"
execute "set <M-4>=\0334"
execute "set <M-5>=\0335"
execute "set <M-6>=\0336"
execute "set <M-7>=\0337"
execute "set <M-8>=\0338"
execute "set <M-9>=\0339"

map <M-;> :ls<CR>:Buffer<Space>
map <M-1> :b1<CR>
map <M-2> :b2<CR>
map <M-3> :b3<CR>
map <M-4> :b4<CR>
map <M-5> :b5<CR>
map <M-6> :b6<CR>
map <M-7> :b7<CR>
map <M-8> :b8<CR>
map <M-9> :b9<CR>

" Toggle spellchecker
map <F2> :call SpellLangToggle()<CR>

function! SpellLangToggle()
  if &spelllang == "en_us"
    setlocal spelllang=
  else
    setlocal spelllang=en_us
  endif
endfunction

" Regenerate ctags quickly.
map <C-@> :!ctags -R .<CR>

" Upward search support for ctags.
set tags=./tags,./TAGS,tags;~,TAGS;~

" Turn off spell check by default.
set spell spelllang=

" Quickly open files.
map <silent> <C-k> :Ex<CR>
