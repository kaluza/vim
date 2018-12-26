
" Brian Presley
" .vimrc

" ctags location
set tags=tags;$DEVEL_TAG_DIRS

execute pathogen#infect()

" set nocompatible b/c some plugins will not work:
set nocompatible
" dont detect file type, leave this to plugins:
filetype off
" run time path:
set rtp+=~/.vim/bundle/Vundle.vim
" vundle#rc can take one optional string argument to change the default prefix where all the plugins are installed:
call vundle#begin()

Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'gmarik/vundle'
Bundle 'vim-scripts/Tagbar'
Bundle 'tomasr/molokai'
Plugin 'scrooloose/syntastic'
Plugin 'Yggdroot/indentLine'
Bundle 'tpope/vim-fugitive'
Bundle 'fatih/vim-go'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'flazz/vim-colorschemes'

" NERDtree configuration -- load if vim is opened without file name. Toggle
" with C-g
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-g> :NERDTreeToggle<CR>

map <C-h> :Tagbar<CR>

colorscheme molokai

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.
set autoindent
set backspace=indent,eol,start
set complete-=i
set showmatch
set showmode
set smarttab

set nrformats-=octal
set shiftround

set ttimeout
set ttimeoutlen=50

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

set autoread

set encoding=utf-8
set tabstop=4 shiftwidth=4 expandtab
set listchars=tab:▒░,trail:▓
set list

inoremap <C-U> <C-G>u<C-U>

set number
set hlsearch
set ignorecase
set smartcase

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" do not history when leavy buffer
set hidden

" FIXME: (broken) ctrl s to save
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>

set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac

" exit insert mode 
inoremap <C-c> <Esc>

set completeopt=menuone,longest,preview

"
" Plugins config
"

" CtrlP
set wildignore+=*/.git/*,*/.hg/*,*/.svn/* 

" Ultisnip
" NOTE: <f1> otherwise it overrides <tab> forever
"let g:UltiSnipsExpandTrigger="<F3>"
"let g:UltiSnipsJumpForwardTrigger="<F3>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"let g:did_UltiSnips_vim_after = 1
"
" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"
" Basic shortcuts definitions
"  most in visual mode / selection (v or ⇧ v)
"

" Find
map <C-f> /
" indend / deindent after selecting the text with (⇧ v), (.) to repeat.
vnoremap <Tab> >
vnoremap <S-Tab> <
" comment / decomment & normal comment behavior
vmap <C-m> gc
" Disable tComment to escape some entities
let g:tcomment#replacements_xml={}
" Text wrap simpler, then type the open tag or ',"
vmap <C-w> S
" Cut, Paste, Copy
vmap <C-x> d
vmap <C-v> p
vmap <C-c> y
" Undo, Redo (broken)
nnoremap <C-z>  :undo<CR>
inoremap <C-z>  <Esc>:undo<CR>
nnoremap <C-y>  :redo<CR>
inoremap <C-y>  <Esc>:redo<CR>
" Tabs
"let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
"nnoremap <C-b>  :tabprevious<CR>
"inoremap <C-b>  <Esc>:tabprevious<CR>i
nnoremap <C-n>  :tabnext<CR>
inoremap <C-n>  <Esc>:tabnext<CR>i
" nnoremap <C-t>  :tabnew<CR>
" inoremap <C-t>  <Esc>:tabnew<CR>i
nnoremap <C-k>  :tabclose<CR>
inoremap <C-k>  <Esc>:tabclose<CR>i

" lazy ':'
map \ :

let mapleader = ','
nnoremap <Leader>p :set paste<CR>
nnoremap <Leader>o :set nopaste<CR>
noremap  <Leader>g :GitGutterToggle<CR>

" this machine config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif


" disable paste commands
inoremap <silent> <F7> <c -O>:call SmartIndentToggle()<cr>
map <silent> <F7> :call SmartIndentToggle()<cr>
function SmartIndentToggle()
    if &autoindent == 1
        echo "Smart Indent Enabled"
        set paste
        set noautoindent
        set nosmarttab
    else
        echo "Smart Indent Enabled"
        set nopaste
        set autoindent
        set smarttab
    endif
endfunction

set spellfile=~/.vim/spellfile.add
inoremap <silent> <F5> <c -O>:call SpellToggle()<cr>
map <silent> <F5> :call SpellToggle()<cr>
function SpellToggle()
    if &spell == 1
        set nospell
        echo "Spell Checker Disabled"
    else
        set spell
        echo "Spell Checker Enabled"
    endif
endfunction

"map <F6> :let &background = (&background == "light" ? "dark" : "light" ) <CR>
inoremap <silent> <F6> <c -O>:call ToggleColorScheme()<cr>
map <silent> <F6> :call ToggleColorScheme()<cr>
function ToggleColorScheme()
    if &background == "light"
        let &background = "dark"
        echo "Assuming dark background"
    else
        let &background = "light"
        echo "Assuming light background"
    endif
endfunction

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END


" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Add template to every python file
 au BufNewFile *.py 0r ~/.vim/templates/python_template.py
 au BufNewFile *.h 0r ~/.vim/templates/c_template.h
