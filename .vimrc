" File: _vimrc
" Version: 1
" Author: Shawn M. Chapla
" Created: 10 Oct 2016 20:35:00

" Last-modified: 29 Dec 2016 10:15:00

" Vundle stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" Share clipboard with MacOS
" set clipboard=unnamed

" Normal backspacing.
set backspace=indent,eol,start

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

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
Plugin 'scrooloose/nerdtree'

" CtrlP fuzzy find
Plugin 'kien/ctrlp.vim'

" Required for Vim Gist plugin
Plugin 'mattn/webapi-vim'

" Vim Gist plugin
Plugin 'mattn/gist-vim' 

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Regular configuration
set expandtab
set number
set hlsearch

set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=0

syntax enable
filetype on

" Add mathematica syntax highlighting for .mma and .wl files.
" au BufNewFile,BufRead *.mma set filetype=mma
" au BufNewFile,BufRead *.wl set filetype=mma


" Press Space to turn off highlighting and clear any messages already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
