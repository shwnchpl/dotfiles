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
" [SEC_0x08] - External Includes

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
    Plugin 'ziglang/zig.vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'elixir-editors/vim-elixir'
    Plugin 'habamax/vim-godot'
    Plugin 'tpope/vim-abolish'
    Plugin 'ocaml/vim-ocaml'
    Plugin 'habamax/vim-asciidoctor'
    Plugin 'shwnchpl/vim-cspicker'
    Plugin 'neovimhaskell/haskell-vim'
    Plugin 'andy-morris/alex.vim'

    " FIXME: Switch back to upstream (s/shwnchpl/dag) if my pull
    " request is ever accepted.
    Plugin 'shwnchpl/vim-fish'

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

" Show details and hidden files in nnn.
let g:nnn#command = 'nnn -dH'

" Make auto-complete suggestions not check include files
" by default as this takes way too long on larger projects.
set complete-=i

" Make new vertical splits open on the right.
set spr

" Break on multi-byte characters when wrapping text and do
" not insert spaces when joining lines that begin/end with
" mutli-byte characters.
set formatoptions+=mM

" Absolutely never write to a read-only file. If I really
" want to write to a file, I can change permissions or
" change this option at runtime. If I can't do either of
" those things, then I definitely do not want to write to
" the file.
set cpoptions+=W

" Make Netrw behavior reasonable for cases when nnn is not
" available.
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Disable haskell-vim indentation.
let g:haskell_indent_disable = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x04] - Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Default formatting profile.
function! s:DefaultFormatting()
    set expandtab
    set tabstop=8
    set softtabstop=4
    set shiftwidth=4
    set textwidth=0
    set colorcolumn=0
    let s:FormattingProfile = 'default'
endfunction

" Linus source formatting profile.
function! s:LinuxSrcFormatting()
    set noexpandtab
    set tabstop=8
    set softtabstop=8
    set shiftwidth=8
    set colorcolumn=81
    highlight ColorColum ctermbg=Black ctermfg=DarkRed
    let s:FormattingProfile = 'linux-src'
endfunction

" Default configuration.
call s:DefaultFormatting()

" Context specific overrides.
if $VIM_FMT_OVERRIDE == "lk-src"
    call s:LinuxSrcFormatting()
elseif $VIM_FMT_OVERRIDE == "email"
    set textwidth=72
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x05] - Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""

set number
set hlsearch
set title
set nowrap
syntax enable

" Make all tabs and trailing whitespace visible.
set list listchars=tab:»\ ,trail:#,extends:»,precedes:«

" Turn on/off spell check by default.
set spell spelllang=en_us

" Set 256 color mode.
set t_Co=256

" Display cursorline only in the active buffer/window.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

if $VIM_NO_PLUGINS != 1
    colorscheme brogrammer
endif

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

function! s:TextModeToggle()
  if exists('s:CompModeToggle_old_tw')
    let &textwidth = s:CompModeToggle_old_tw
    unlet s:CompModeToggle_old_tw
  else
    let s:CompModeToggle_old_tw = &textwidth
    let &textwidth = 72
  endif
endfunction

com! TextModeToggle call s:TextModeToggle()

function! s:LinuxSrcToggle()
    if s:FormattingProfile != 'default'
        call s:DefaultFormatting()
    else
        call s:LinuxSrcFormatting()
    endif
endfunction

com! LinuxSrcToggle call s:LinuxSrcToggle()

function! s:StripEmailNewlines()
    let l:old_tw = &textwidth
    let &textwidth = 100000
    normal gg}gqG
    let &textwidth = l:old_tw
endfunction

com! StripEmailNewlines call s:StripEmailNewlines()

" Convenience function/command for appending a new row to my daily
" personal data tracking CSV file.
function! s:AppendDPDRow()
    normal! G
    put =strftime('%Y-%m-%d,%a,xx:xx,xx:xx,0000,0000,0,0,-1,\"\"')
endfunction

com! AppendDPDRow call s:AppendDPDRow()

function! s:Geist()
    let bn = bufname('%')
    let key = systemlist(g:geist_key_cmd)[0]
    let cmd = 'curl --silent -F "data=@' . bn . '" -H "GeistApiKey: ' . key
    let cmd = cmd . '" ' . g:geist_server
    echo systemlist(cmd)[0]
endfunction

com! Geist call s:Geist()

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

" Toggle word wrapping.
map <F3> :TextModeToggle<CR>

" Toggle text-mode width.
map <F4> :set wrap!<CR>

" Toggle paste mode.
map <F5> :set paste!<CR>

" Reload .vimrc.
map <F6> :source ~/.vimrc<CR>

" Toggle Linux source style formatting.
map <F7> :LinuxSrcToggle<CR>

" Regenerate ctags quickly.
map <C-@> :!ctags -R .<CR>

" Quick shortcut for opening new files visually.
if $VIM_NO_PLUGINS != 1
    map <C-k> :NnnPicker %:p:h<CR>
else
    map <C-k> :edit .<CR>
endif

map <Leader>U yypv$r=
map <Leader>u yypv$r-

" In netrw, make gn simply invoke :Ntree instead of using
" its own special handling, which is noisy about 'errors'
" when selecting a file to indicate target directory level.
augroup netrw_ntree_gn
    autocmd!
    autocmd FileType netrw map <buffer>gn :Ntree<CR>
augroup end

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

" Treat golang files as Linux kernel style source.
autocmd FileType go call s:LinuxSrcToggle()

" Indent certain files with only two spaces.
augroup double_space_indent
    autocmd!
    autocmd FileType ocaml setlocal shiftwidth=2 softtabstop=2
    autocmd FileType html setlocal shiftwidth=2 softtabstop=2
    autocmd FileType haskell setlocal shiftwidth=2 softtabstop=2
    autocmd FileType alex setlocal shiftwidth=2 softtabstop=2
augroup END

augroup functional_indentation
    autocmd!
    autocmd FileType haskell setlocal autoindent nocindent smartindent
    autocmd FileType alex setlocal shiftwidth=2 softtabstop=2
augroup END

" Enable 'text mode' by default for certain plaintext file types.
augroup text_mode_default
    autocmd!
    autocmd FileType asciidoc,asciidoctor setlocal tw=72
    autocmd FileType markdown setlocal tw=72
    autocmd FileType rst setlocal tw=72
    autocmd FileType text setlocal tw=72
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""
" [SEC_0x08] - External Includes
"""""""""""""""""""""""""""""""""""""""""""""""""""

let s:vimrc_secure = $HOME . '/.vimrc.secure'
if filereadable(s:vimrc_secure)
    exec 'source ' . s:vimrc_secure
endif
