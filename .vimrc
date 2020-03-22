" File: _vimrc
" Version: 1
" Author: Shawn M. Chapla
" Created: 10 Oct 2016 20:35:00
" Last-modified: 28 Oct 2018 17:00:00

" Vundle stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" Share clipboard with MacOS
" set clipboard=unnamed

" Normal backspacing.
set backspace=indent,eol,start

" Uncomment for a status line with file name.
" set statusline+=%f
" set laststatus=2

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

" Colorschemes
" Plugin 'flazz/vim-colorschemes'

" CtrlP fuzzy find
"Plugin 'kien/ctrlp.vim'

" Required for Vim Gist plugin
"Plugin 'mattn/webapi-vim'

" Vim Gist plugin
"Plugin 'mattn/gist-vim'

" nnn file manager plugin
"Plugin 'mcchrish/nnn.vim'

" ANTLR4 syntax highlighting
"Plugin 'dylon/vim-antlr'

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

  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  set textwidth=0
endif

" Add mathematica syntax highlighting for .mma and .wl files.
" au BufNewFile,BufRead *.mma set filetype=mma
" au BufNewFile,BufRead *.wl set filetype=mma

" Press Space to turn off highlighting and clear any messages already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Make all trailing whitespace and tabs visible.
set list listchars=tab:»\ ,trail:#,extends:»,precedes:«

" Make them really ugly too.
" :hi SpecialKey ctermfg=grey ctermbg=red guifg=grey70

" Fast buffer movement.
" execute "set <M-j>=\033j"
" execute "set <M-k>=\033k"
" execute "set <M-l>=\033l"
" execute "set <M-[>=\033["
" execute "set <M-]>=\033]"
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
"execute "set <M-h>=\033h"
" map <M-]> :bnext<CR>
" map <M-[> :bprev<CR>
map <M-;> :ls<CR>:buffer<Space>
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

" Turn on/off spell check by default.
" set spell spelllang=en_us
set spell spelllang=

" Quick shortcut for opening new files visually.
map <C-k> :Ex<CR>
"map <C-k> :NnnPicker '%:p:h'<CR>

" Another fast buffer switching option.
nnoremap ,b :ls<CR>:buffer<Space>

" Comment and uncomment lines of code fast.
augroup fast_src_comments
    autocmd!
    autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
    autocmd FileType sh,ruby,python   let b:comment_leader = '# '
    autocmd FileType conf,fstab       let b:comment_leader = '# '
    autocmd FileType tex              let b:comment_leader = '% '
    autocmd FileType mail             let b:comment_leader = '> '
    autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Show hidden files in nnn.
let g:nnn#command = 'nnn -d'

" Make selecting an auto-complete suggestion easier.
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))

" Make auto-complete suggestions not check include files
" by default as this takes way too long on larger projects.
set complete-=i

" Set 256 color mode.
" set t_Co=256

" Set color scheme.
" set background=dark
" colorscheme OceanicNext
" colorscheme Atelier_ForestDark
" colorscheme SerialExperimentsLein
" colorscheme sean
colorscheme kalahari

" Make spelling highlight color more readable so I'm less
" apt to turn it off and make mistakes.
"hi SpellBad ctermbg=005
