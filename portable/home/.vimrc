" File: .vimrc
" Version: 2
" Author: Shawn M. Chapla
" Created: 10 Oct 2016 20:35:00
" Updated: 25 May 2020 14:15:00

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x00] - Table of Contents
"""""""""""""""""""""""""""""""""""""""""""""""""""

" [SEC_0x00] - Table of Contents
" [SEC_0x01] - Context
" [SEC_0x02] - Plugins
" [SEC_0x03] - Behavior
" [SEC_0x04] - Formatting
" [SEC_0x05] - Appearance
" [SEC_0x06] - Functions and Commands
" [SEC_0x07] - Mappings

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x01] - Context
"""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x02] - Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""

if $VIM_NO_PLUGINS != 1
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    Plugin 'flazz/vim-colorschemes'
    Plugin 'mattn/webapi-vim'
    Plugin 'mattn/gist-vim'
    Plugin 'mcchrish/nnn.vim'
    Plugin 'dylon/vim-antlr'
    Plugin 'cespare/vim-toml'

    call vundle#end()
    filetype plugin indent on
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x03] - Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""

filetype on

" Normal backspacing.
set backspace=indent,eol,start

" Upward search support for ctags.
set tags=./tags,./TAGS,tags;~,TAGS;~

" Show hidden files in nnn.
let g:nnn#command = 'nnn -d'

" Make auto-complete suggestions not check include files
" by default as this takes way too long on larger projects.
set complete-=i

" Make new vertical splits open on the right.
set spr

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x04] - Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Defaults
set expandtab

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0

" Overrides
if $VIM_FMT_OVERRIDE == "lk-src"
    set noexpandtab

    set tabstop=8
    set softtabstop=8
    set shiftwidth=8

    set colorcolumn=81
    highlight ColorColum ctermbg=Black ctermfg=DarkRed
elseif $VIM_FMT_OVERRIDE == "email"
  set textwidth=72
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x05] - Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""

set number
set hlsearch
set title
syntax enable

" Make all tabs and trailing whitespace visible.
set list listchars=tab:»\ ,trail:#,extends:»,precedes:«

" Turn on/off spell check by default.
set spell spelllang=en_us

" Set 256 color mode.
set t_Co=256

colorscheme kalahari

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x06] - Functions and Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""

function! SpellLangToggle()
  if &spelllang == "en_us"
    setlocal spelllang=
  else
    setlocal spelllang=en_us
  endif
endfunction

function! s:StripEmailNewlines()
    let l:old_tw = &textwidth
    let &textwidth = 100000
    normal gg}gqG
    let &textwidth = l:old_tw
endfunction

com! StripEmailNewlines call s:StripEmailNewlines()

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x07] - Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Press Space to turn off highlighting and clear any messages
" already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Toggle spellchecker
map <F2> :call SpellLangToggle()<CR>

" Regenerate ctags quickly.
map <C-@> :!ctags -R .<CR>

" Quick shortcut for opening new files visually.
map <C-k> :NnnPicker '%:p:h'<CR>

" Make selecting an auto-complete suggestion easier.
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("\<C-j>"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("\<C-k>"))

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
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')
    \ <CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')
    \ <CR>//e<CR>:nohlsearch<CR>