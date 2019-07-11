set nocompatible              " be iMproved, required
filetype off                  " required
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set number

set foldmethod=syntax
set foldlevelstart=1

let javaScript_fold=1
let sh_fold_enabled=1

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'pangloss/vim-javascript'
Plugin 'hdima/python-syntax'
Plugin 'ryanoasis/vim-devicons'
Plugin 'fatih/vim-go'
Plugin 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"set encoding=utf-8
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:molokai_original = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

colorscheme Dev_Delight
