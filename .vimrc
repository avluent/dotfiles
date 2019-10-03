" Unset vi compatibility
set nocompatible

"---------- VUNDLE ----------
"set off filetype
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vundle plugins go here
Plugin 'vim-airline/vim-airline'
Plugin 'sheerun/vim-polyglot'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'

" end of Vundle plugins
call vundle#end()            " required
filetype plugin indent on    " required
"---------- VUNDLE ----------

"Set the correct Color Scheme
colorscheme Tomorrow-Night-Eighties

"Some global options
set nu	 
set shiftwidth=2
set tabstop=2
set autoindent
