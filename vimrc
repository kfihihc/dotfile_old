" vim :set fdm=marker tw=4 "

" => pathogen setup {{{
" set up pathogen, https://github.com/tpope/vim-pathogen
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
call pathogen#infect()
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
filetype plugin indent on
"}}}

" => basic setup {{{
" not compatible for vi ...
set nocompatible

if has("mac")
    "for vim-cocoa
    let $PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin:/Users/xiaobo/Documents/android-sdk-mac_86/tools:/Users/xiaobo/Documents/android-sdk-mac_86/platform-tools:/Users/xiaobo/Documents/android-ndk"

"}}}
