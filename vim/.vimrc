" A lot of this configuration was copied from Miguel Grinberg's vimrc
" See https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" General  """""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
set nocompatible
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" vim-plug  """"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins. Run :PlugInstall to download them.
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'ap/vim-buftabline'
" vim-surround: all about surroundings: brackets, quotes, etc.
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
" dracula: dracula color scheme
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'SirVer/ultisnips'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/tagbar'
" Vim-Jinja2-Syntax: Jinja2 sytnax highlighting
Plug 'Glench/Vim-Jinja2-Syntax'
" vim-pandoc: Pandoc integration
Plug 'vim-pandoc/vim-pandoc'
" vim-pandoc-syntax: Pandoc markdown syntax
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/indentpython.vim'
Plug 'pangloss/vim-javascript'
Plug 'alvan/vim-closetag'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""" User interface  """""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ignore case when searching
set ignorecase 

" When searching, try to be smart about cases
set smartcase 

" Highlight search results
set hlsearch 

" Makes search act like search in modern browsers
set incsearch 

" Show matching brackets when text indicator is over them
set showmatch

" Show line numbers
set number

" Set utf8 as standard encoding
set fileformat=unix
set encoding=utf8 
set fileencoding=utf-8

" Set a margin at 80 characters
set colorcolumn=88

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""" Text, tab, indent """"""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 2 or 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType r setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType c setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Copy the identation of the previous line
set autoindent

" Insert one extra level of indentation in some cases
set smartindent

" Insert linebreak at 87 characters
set textwidth=87
let g:pandoc#formatting#textwidth=87
let g:pandoc#formatting#mode = "h"

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""" Color and fonts " """"""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax highlighting
syntax enable
set termguicolors
"set background=dark
colorscheme dracula

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""" Status line """""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Lightline configuration
let g:lightline = {'colorscheme': 'dracula',}
"
" Use lightline instead of the default vim message
set noshowmode 

" Always show the status line
set laststatus=2 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""" Mouse """"""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    if g:is_mouse_enabled == 1
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" UltiSnips """"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""" vim-pandoc """"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable folding
let g:pandoc#modules#disabled = ["folding"]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""" auto-pairs """"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""" tagbar """"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>t :TagbarToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""" NERDTree """""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
map <leader>n :call NERDTreeToggle()<CR>
function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""" Buftabline """"""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""" ALE """""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set ALE C++ options
let g:ale_cpp_gcc_options = '-Werror -Wall -Weffc++ -Wextra -Wsign-conversion -pedantic-errors -std=c++17'
let g:ale_linters = {'c': ['gcc'], 'cpp': ['g++'], 'python': ['flake8', 'pylint']}
