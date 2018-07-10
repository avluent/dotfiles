" ##### Vundle #####

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'

call vundle#end()            " required
filetype plugin indent on    " required

" ##### End Vundle #####

" Set Colorscheme
colorscheme molokai


" Global Settings
set paste
set number " Line Numbers
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Highlighting +80 colums
highlight OverLength ctermbg=blue ctermfg=yellow guibg=#592929
match OverLength /\%81v.\+/
