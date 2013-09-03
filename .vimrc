" vim :set fdm=marker tw=4 "

" => pathogen setup {{{
" set up pathogen, https://github.com/tpope/vim-pathogen
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
call pathogen#infect()
filetype plugin indent on
"}}}

" => basic setup {{{
" not compatible for vi ...
set nocompatible


"}}}
