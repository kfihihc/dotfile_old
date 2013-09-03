" vim :set fdm=marker tw=4 "

" => pathogen setup {{{
" set up pathogen, https://github.com/tpope/vim-pathogen
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
call pathogen#incubate()
call pathogen#helptags()
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
"}}}

" => init vim setup {{{
" not compatible for vi ...
set nocompatible

if has("mac")
    "for vim-cocoa
    let $PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin:/Users/xiaobo/Documents/android-sdk-mac_86/tools:/Users/xiaobo/Documents/android-sdk-mac_86/platform-tools:/Users/xiaobo/Documents/android-ndk"
endif

" goto the last edit position when open file
if has("autocmd")
    au BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
endif
"}}}

" => common configure for vim {{{
let mapleader = ","
let g:mapleader = ","
nnoremap ; :

set autoindent
set history=700                 " history line
set autoread                    " reload file when changed on disk

" c filetype indent
autocmd BufEnter *.{c,h} setlocal cindent
" list filetype indent
autocmd BufEnter *.{lisp,scheme,ss,scm,el,clj} setlocal lisp

" some filetype will not be indent, like markdown, wiki
au BufEnter,BufNewFile,BufRead *{mmd,multimarkdown,pandoc,pd,pdk} setlocal filetype=pandoc
autocmd BufEnter *.{wiki,txt,text,md,mkd,markdown,pd,pdk,pandoc} setlocal nosmartindent

if has("syntax")
  syntax on
  syntax enable
endif
" }}}

" => key map setup {{{
" => normal key map {{{2
if has(mac || linux)
    map <silent> <leader>ss :source ~/.vimrc<cr>
    map <silent> <leader>ee :e ~/.vimrc<cr>
elseif has(win32)
    map <silent> <leader>ss :source ~/_vimrc<cr>
    map <silent> <leader>ee :e ~/_vimrc<cr>
endif

imap <c-j> <ESC>                " key map for ESC

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

" normal edit map
map <silent> <leader>q  :q<cr>
map <silent> <leader>w   :w<cr>
map <silent> <leader>wq  :wq<cr>
map <silent> <leader>qa  :qa<cr>

" toggle list
noremap <Leader>i :set list!<CR>

" General Abbrevs
" iab xdate <c-r>=strftime("%y/%m/%d %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%y-%m-%d")<cr>
iab blogdate <c-r>=LunarDay()<cr>，西曆 <c-r>=strftime("%Y/%m/%d")<cr>
iab lunardate <c-r>=LunarDay()<cr>
"iab lunardate <c-r>=!ccal -u -b <cr>
nmap <leader>m <ESC>:!ccal -u <cr>
"}}}2

" => navigate buffer/tab key map {{{2
" windows switch
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" move window buffer and change the size
map <S-w>j <C-W>J
map <S-w>k <C-W>K
map <S-w>h <C-W>H
map <S-w>l <C-W>L
map <S-w>- <C-W>L

" use ,F to jump to tag in a vertical split
nnoremap <silent> <leader>F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>
" use ,gf to go to file in a vertical split
nnoremap <silent> <leader>gf :vertical botright wincmd f<CR>

" Close the current buffer
map <leader>bb :bd<cr>
" Close the curent buffer and goto previous buffer
if has(mac)
    map <D-w> :bd<cr> :bp<cr>
elseif has(linux || win32)
    map <M-w> :bd<cr> :bp<cr>
endif
" Close all the buffers
map <leader>ba :1,300 bb!<cr>

" tab nubmer navigate
if has(mac)
    map <D-1> 1gt
    map <D-2> 2gt
    map <D-3> 3gt
    map <D-4> 4gt
    map <D-5> 5gt
    map <D-6> 6gt
    map <D-7> 7gt
    map <D-8> 8gt
    map <D-9> 9gt
    map <D-0> :tablast<CR>
endif

" edit tab configure
map tn :tabnew<cr>
map te :tabedit
map tc :tabclose<cr> :bd<cr>  :bp<cr>
map tm :tabmove

" switch to pwd
map <leader>cd :cd %:p:h<cr>
"}}}2 

"Reselect visual block after indent/outdent 
vnoremap < <gv
vnoremap > >gv
" }}}

" => interface for vim {{{
" => normal interface setup for vim {{{2
set scrolloff=5                         " screen line to keep at last
set number                              " line number
set mouse=a                             " mouse support
set showcmd                             " show the command
set showmode                            " show vim mode
set ruler                               " display the the cursor' position
set cmdheight=2                         " command line height
set directory-=.                        " don't store .swp file in current dir
" set hid
set completeopt=longest,menu,preview
set clipboard=unnamed
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase                          " ignore case when search
set smartcase
set hlsearch
set incsearch
set nolazyredraw
set magic "Set magic on, for regular expressions
set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink
set noerrorbells " No sound on errors
set novisualbell
set t_vb=  " visual bell
set tm=500
set ffs=unix,mac,dos
set list                                " for special char
set listchars=tab:\¦\.,trail:~,extends:>,precedes:<,nbsp:%
" set listchars=eol:¶
set listchars=eol:¬
set expandtab                           " expand tab to sapce
set shiftwidth=4
set tabstop=4
set smarttab
set wildmenu                            " show the command complete
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry
" }}}2

" => Statusline {{{2
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
   let curdir = substitute(getcwd(), '/Users/xiaobo/', "~/", "g")
   return curdir
endfunction

function! HasPaste()
   if &paste
      return 'PASTE MODE  '
   else
      return ''
   endif
endfunction
"}}}2

" => font and colorful {{{2
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5
set termencoding=utf-8
set langmenu=zh_CN.UTF-8
language zh_CN.UTF-8
language message zh_CN.UTF-8
language time zh_CN.UTF-8

if has('gui_running')
    " set background=light
    set t_Co=256
else
    " set background=dark
endif

colorscheme molokai "solarized "MySand "zenburn "bensday "desert rainbow_neon lucius
" for molokai colorscheme
let g:molokai_original = 1
" for solarized
let g:solarized_termcolors   = 256
" let g:solarized_termcolors = 16
let g:solarized_termtrans    = 1
" let g:solarized_bold       = 1
" let g:solarized_underline  = 1
" let g:solarized_italic     = 1
let g:solarized_degrade      = 1
" let g:solarized_visibility = "low"
let g:solarized_hitrail      = 0
let g:solarized_menu         = 1
let g:solarized_contrast     = "normal"
let g:solarized_visibility   = "normal"
let g:solarized_diffmode     = "normal"
let g:solarized_menu         = 1

if has(mac)
    set guifont=Inconsolata\-dz\ for\ Powerline:h14
    set guifontwide=宋体-方正超大字符集:h14
endif

" highlight for non-text
hi NonText ctermfg=247 guifg=#b0b0b0 cterm=bold gui=bold
hi SpecialKey ctermfg=77 guifg=#654321
" }}}2

" => text display mode {{{2
" " set column
" " set colorcolumn=81
" set cc=+1
" " hi ColorColumn ctermbg=lightgrey guibg=white

" " 设置断行
" set lbr
" set showbreak=↪

" " 对超过 79 个字符的长行使用回绕
" set wrap
" set textwidth=80
" set formatoptions+=croqmB1

" autocmd BufEnter *.{wiki,txt,md,mkd,markdown,pandoc} setlocal fo+=2

" code fold
set foldenable
set foldmethod=marker
set foldnestmax=3
set foldcolumn=3
" }}}2

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" => code operating {{{
" => code format {{{2
" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Specify path to your Uncrustify configuration file.
let g:uncrustify_cfg_file_path =
    \ shellescape(fnamemodify('~/.uncrustify.cfg', ':p'))

" Don't forget to add Uncrustify executable to $PATH (on Unix) or 
" %PATH% (on Windows) for this command to work.
function! Uncrustify(language)
  call Preserve(':silent %!uncrustify'
      \ . ' -q '
      \ . ' -l ' . a:language
      \ . ' -c ' . g:uncrustify_cfg_file_path)
endfunction

" for java like this
" autocmd BufWritePre <buffer> :call Uncrustify('java')
" }}}2
" }}}
