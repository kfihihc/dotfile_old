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
if has("mac" || "unix")
    map <silent> <leader>ss :source ~/.vimrc<cr>
    map <silent> <leader>ee :e ~/.vimrc<cr>
elseif has("win32")
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

" switch buffer with S-l and S-h
map <S-l> :bn<cr>
map <S-h> :bp<cr>
" Close the current buffer
map <leader>bb :bd<cr>
" Close the curent buffer and goto previous buffer
if has("mac")
    map <D-w> :bd<cr> :bp<cr>
elseif has(linux || win32)
    map <M-w> :bd<cr> :bp<cr>
endif
" Close all the buffers
map <leader>ba :1,300 bb!<cr>

" tab nubmer navigate
if has("mac")
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

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

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
set hid
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
" set wildmode=longest,list,full

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

colorscheme molokai
" colorschem solarized "MySand "zenburn "bensday "desert rainbow_neon lucius

" for molokai colorscheme
let g:molokai_original = 1
let g:rehash256 = 1

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

if has("mac")
    set guifont=Inconsolata\-dz\ for\ Powerline:h14
    set guifontwide=宋体-方正超大字符集:h14
endif

" highlight for non-text
hi NonText ctermfg=247 guifg=#b0b0b0 cterm=bold gui=bold
hi SpecialKey ctermfg=77 guifg=#654321
" }}}2

" => text display mode {{{2
" set column
" set colorcolumn=81
set cc=+1
" hi ColorColumn ctermbg=lightgrey guibg=white

" " 设置断行
" set lbr
" set showbreak=↪

" " 对超过 79 个字符的长行使用回绕
set wrap
set textwidth=80
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

" => plugin setup {{{

" plugin abstract key map{{{2
nnoremap [DrawIt] <Nop>
map <F10> [DrawIt]
noremap [emotion] <Nop>
noremap [emotion]<Space> f
map f [emotion]
nnoremap [Gtags] <Nop>
map <F3> [Gtags]
nnoremap [surround] <Nop>
" nnoremap [surround] <Space> t
map <F5> [surround]
" noremap [multicursor] <Nop>
" noremap [multicursor]<Space> n
" map n [multicursor]

" stardict
nmap <F9> :!sdcv "<cword>" <C-R>=expand("<cword>")<CR><CR>
imap <F9> <ESC>:!sdcv "<cword>" <C-R>=expand("<cword>")<CR><CR>
"}}}2

" => NerdComment and NerdTree{{{2
let NERDSpaceDelims=1

let NERDTreeWinPos = "left" "where NERD tree window is placed on the screen
let NERDTreeWinSize = 30 "size of the NERD tree
" autocmd VimEnter * NERDTree "启动Vim时自动打开nerdtree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
nmap <F7> <ESC>:NERDTreeToggle<cr>
" }}}2

" => CtrlP {{{2
map <leader>rf :CtrlPMRUFiles<cr>
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$\|\.DS_Store$'
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_map = '<c-p>'
" <c-f> <c-b> to switch between mode
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_cache_dir = $HOME.'/.vim/.cache/ctrlp'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir', 'funky']

" for VCS search improve
let g:ctrlp_user_command = {
  \ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files -c -o'],
  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': 'find %s -type f'
  \ }
"}}}2

" => ack with the silver searcher {{{2
if executable('ag')
    let g:ackprg = 'ag --column'
    nnoremap <leader>a :Ack 
    " nnoremap [emotion]a :Ack 
    " nnoremap [emotion]A :AckFile 
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
    " let Grep_Skip_Dirs = '*.bak .git .DS_Store .bzr .hg *~ RCS CVS SCCS .svn generated'
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" }}}2

" => TagBar and powerline {{{2
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme='solarized256'
nmap <F8> :TagbarToggle<CR>
" let g:tagbar_ctags_bin='/usr/local/bin/ctags -f - --format=2 --excmd=pattern --extra= --fields=nksaSmt myfile'
" let g:tagbar_autoshowtag = 1
" let g:tagbar_autoclose = 1
" let g:tagbar_sort = 0

" for txt
" let tagbar_type_txt = {
  " \ 'ctagstype' : 'txt',
  " \ 'kinds'     : [
    " \ 'c:content',
    " \ 'f:figures',
    " \ 't:tables'
    " \]
  " \}
" autocmd FileType c,cpp nested :TagbarOpen
" highlight TagbarScope guifg=Green ctermfg=Green
" }}}2

" => easy motion {{{2
let g:EasyMotion_leader_key = '[emotion]'
" }}}2

" => tabular {{{2
" let g:tabular_loaded = 1
nmap <leader>tl <ESC>:Tabularize /
" }}}2

" => Better Rainbow Parentheses {{{2
let g:rbpt_colorpairs = [
  \ ['brown',       'RoyalBlue3'],
  \ ['Darkblue',    'SeaGreen3'],
  \ ['darkgray',    'DarkOrchid3'],
  \ ['darkgreen',   'firebrick3'],
  \ ['darkcyan',    'RoyalBlue3'],
  \ ['darkred',     'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['brown',       'firebrick3'],
  \ ['gray',        'RoyalBlue3'],
  \ ['black',       'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['Darkblue',    'firebrick3'],
  \ ['darkgreen',   'RoyalBlue3'],
  \ ['darkcyan',    'SeaGreen3'],
  \ ['darkred',     'DarkOrchid3'],
  \ ['red',         'firebrick3'],
  \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 1
map rbp :RainbowParenthesesToggle<CR>
autocmd BufEnter, BufRead *.{lisp,scheme,ss,scm,el,clj} RainbowParenthesesLoadRound
"}}}2

" => showmarks and woxmarks {{{2 
let g:showmarks_include='abcdefghijklmnopqrstuvwxyz' . 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:showmarks_ignore_type=""
let g:showmarks_textlower="\t"
let g:showmarks_textupper="\t"
let g:showmarks_textother="\t"
let g:showmarks_auto_toggle = 0
nnoremap <silent> mo :ShowMarksOn<CR>
nnoremap <silent> mt :ShowMarksToggle<CR>

let g:wokmarks_do_maps = 0
let g:wokmarks_pool = "abcdefghijklmnopqrstuvwxyz"
map mm <Plug>ToggleMarkWok
map mj <Plug>NextMarkWok
map mk <Plug>PrevMarkWok
map <M-Left> <Plug>SetMarkWok
map <M-Right> <Plug>ToggleMarkWok
map <M-Up> <Plug>PrevMarkWok
map <M-Down> <Plug>NextMarkWok
autocmd User WokmarksChange :ShowMarksOn
"}}}2

" => vimwiki {{{2
let g:vimwiki_use_mouse = 1
if has('mac')
    let g:vimwiki_list = [ {
                \ 'path'            : '~/Dropbox/wiki/',
                \ 'path_html'        : '~/Dropbox/wiki/html/',
                \ 'syntax'           : 'markdown',
                \ 'ext'              : '.md',
                \ 'nested_syntaxes'  : {
                    \ 'c'           : 'c',
                    \ 'bash'        : 'bash',
                    \ 'cpp'         : 'cpp',
                    \ 'java'        : 'java',
                    \ 'python'      : 'python',
                    \ 'objective-c' : 'objective-c',
                    \ 'scheme'      : 'scheme',},
                    \},
                \ {'path'            : '~/Dropbox/blog.yuzhe.me/posts',
                \ 'systax'           : 'pandoc',
                \ 'ext'              : '.pandoc'},
                \ {'path'             : '/Users/xiaobo/Dropbox/vimwiki_blog/',
                \ 'path_html'        : '/Users/xiaobo/Dropbox/Public/blog/',
                \ 'template_path'    : '~/Dropbox/vimwiki_blog/template',
                \ 'template_default' : 'template',
                \ 'template_ext'     : '.tpl',
                \ 'css_name'         : 'css/template.css'},
                \ {'path'            : '~/Dropbox/vimwiki/',
                \ 'path_html'        : '~/Dropbox/vimwiki/html/'},
                \ {'path'            : '~/Dropbox/notes/',
                \ 'path_html'        : '~/Dropbox/notes/html/'},
                \ {'path'            : '~/Documents/SeeedStudio/Dropbox/notes/',
                \ 'path_html'        : '~/Documents/SeeedStudio/Dropbox/notes/html/',
                \ 'systax'           : 'markdown',
                \ 'ext'              : '.md'}]
else
    let g:vimwiki_list = [{
                \ 'path'             : '~/Dropbox/wiki',
                \ 'path_html'        : '~/Dropbox/Public/blog/',
                \ 'template_path'    : '~/Dropbox/vimwiki_blog/template',
                \ 'template_default' : 'template',
                \ 'template_ext'     : '.tpl',
                \ 'css_name'         : 'css/template.css'}]
endif

let g:vimwiki_folding=1
let g:vimwiki_customwiki2html=$HOME.'/.vim/autoload/vimwiki/customwiki2html.sh'
"let g:vimwiki_CJK_length =1
" au BufNewFile,BufRead *.wiki set filetype=wiki
map <leader>td <Plug>VimwikiToggleListItem
"}}}2

" => surround {{{2
" change surround
nmap [surround]c cs

"b, B, r, and a are aliases for ), }, ], and >.
let b:surround_{char2nr("0")} = "(\r)"
let b:surround_{char2nr("t")} = "`\r`"
let b:surround_{char2nr("j")} = "\"\r\""
let b:surround_{char2nr("i")} = "*\r*"
let b:surround_{char2nr("s")} = "**\r**"
" (), {}, [], <>
nmap [surround]b viwSbW
imap [surround]b <ESC>viwSbWi
" nmap [surround]0 ds)
" imap [surround]0 <ESC>ds)
nmap [surround]B viwSBW
imap [surround]B <ESC>viwSBWi
nmap [surround]r viwSrW
vmap [surround]r viwSrW
imap [surround]r <ESC>viwSrWi
nmap [surround]a viwSaW
imap [surround]a <ESC>viwSaWi
" ``
nmap [surround]t viwStW
imap [surround]t <ESC>viwStWi
nmap [surround]T ds`
imap [surround]T <ESC>ds`i
" ""
nmap [surround]j viwSrW
imap [surround]j <ESC>viwSrWi
nmap [surround]J ds"
imap [surround]J <ESC>ds"i
" **
nmap [surround]i viwSiW
imap [surround]i <ESC>viwSiWi
nmap [surround]I dsi
imap [surround]I <ESC>dsii
" ** **
nmap [surround]s viwSsW
imap [surround]s <ESC>viwSsWi
"}}}2

" => Minibuffer plugin {{{2
let g:miniBufExplModSelTarget       = 1
let g:miniBufExplorerMoreThanOne    = 0
let g:miniBufExplUseSingleClick     = 1
let g:miniBufExplMapWindowNavVim    = 1
"let g:miniBufExplVSplit            = 25
"let g:miniBufExplSplitBelow=1
let g:miniBufExplMapCTabSwitchBufs  = 1
" let g:miniBufExplCheckDupeBufs = 0
" let g:miniBufExplForceSyntaxEnable = 1

let g:bufExplorerSortBy = "name"

" autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>
"}}}2

" => xptemplate {{{2
let g:xptemplate_key ='<D-/>'
let g:xptemplate_key_pum_only = '<S-Tab>'
"}}}2

" => ywvim {{{2
let g:ywvim_ims=[
          \['zm', '鄭碼', 'zhengma.ywvim'],
          \['py', '拼音', 'pinyin.ywvim'],
          \]
let g:ywvim_zm = { 'helpim':'py' }

let g:ywvim_zhpunc = 1 "中文标点输入开关
let g:ywvim_listmax = 4 "候选项个数
let g:ywvim_esc_autoff = 0 "设置离开插入模式时是否自动关闭 ywvim
let g:ywvim_autoinput = 1 "支持两种程度的自动模式. 设为 2 为重度自动, 任何单码字都自动上屏
let g:ywvim_circlecandidates = 1 "候选页中循环翻页
let g:ywvim_helpim_on = 1 "打开反查码表的功能
let g:ywvim_matchexact = 0 "只显示全码匹配的字
let g:ywvim_chinesecode = 1 "顯示注音字母
let g:ywvim_gb = 0 "只输入 gb2312 范围汉字
let g:ywvim_preconv = 'g2b' "默认简繁转换方向，'g2b' 為簡軟繁, 'b2g' 為繁轉簡
let g:ywvim_conv = ''
let g:ywvim_lockb = 1 "为 0 时, 在空码是不锁定键盘
"}}}2

" => Set Calendar {{{2
let g:calendar_navi_label = '向上,今天,向下'
let g:calendar_mruler = '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月'
let g:calendar_wruler = '日 一 二 三 四 五 六'
let g:calendar_datetime = 'title'
"NOTE:you can set 'title', 'statusline', '' for this option.
"}}}2

" => YouCompleteMe {{{2
let g:ycm_key_invoke_completion ='<D-\>'
let g:ycm_key_list_previous_completion = ['<C-TAB>']
" let g:ycm_key_list_select_completion = ['<TAB>', '<Enter>']
let g:ycm_key_list_select_completion = ['<C-Enter>']
let g:ycm_allow_changing_updatetime = 1
let g:ycm_filetypes_to_completely_ignore = {
  \ 'markdown' : 1,
  \ 'md' : 1,
  \ 'pandoc' : 1,
  \ 'pd' : 1,
  \ 'txt' : 1,
  \ 'vim' : 1,
  \ 'python' : 1,
  \}

let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,vim,ruby,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
" }}}2

" => xmms2 palyer {{{2
" " vimmp
" if has('python')
  " py import os, sys
  " py sys.path.append(os.path.expanduser("/Users/xiaobo/.vim/bundle/vimmp/"))
  " pyf /Users/xiaobo/.vim/bundle/vimmp/main.py
" endif

" let g:vimmp_server_type="xmms2"
" nmap <silent> <leader>x :py vimmp_toggle()<cr>
" let g:xmms_window_width=40
" "default is "%artist - %title", %album
" let g:xmms_playlist_format="%title"

" usage
" Use <leader>x to toggle the play window.
"
"   Also the following key shorts are available. Most key maps start with
"   c(Contrl) or l(playList).
"
"     <space>    Play the song under cursor.
"     <cr>       Same as <space>.
"     cs         Stop.
"     cp         Pause.
"     cr         Select a repeat mode.
"                There are three modes for XMMS2: one, all, off.
"                For MPD, there are two: off, all. So there command just toggle.
"     -          Decrease volume.
"     =          Increase volume.
"     r          Refresh window manually.
"     la         Add a file or directory to playlist.
"     lc         Clear the playlist.
"     ld         Remove the song under cursor from current playlist.
"     lf         Shuffer the list.
"     ll         Load a playlist.
"     ln         Create a new playlist, and save current contents to it.
"     ls         Sort the playlist, by artist, title or filename.
"                Only available for XMMS2.
"}}}2

" => DrawIt {{{2
" <leader>di and <leader>ds is default map
map [DrawIt]s :DIsngl<cr>
map [DrawIt]d :DIdbl<cr>
map [DrawIt]b :SetBrush a
"}}}2

" => slimv {{{2
" let g:slimv_swank_cmd = '!osascript -e "tell application \"iTerm\""
" let g:slimv_swank_scheme = '!osascript -e "tell application \"iTerm\""
let g:scheme_builtin_swank = 1
let g:slimv_leader='\'
" }}}2

" => pandoc and markdown etc preview {{{2
map <leader>mm :PandocHtmlOpen<cr>
" }}}2

" => pydoc.vim and rope.vim and python-mode {{{2
" " let g:pydoc_cmd = '/usr/bin/pydoc'
" let g:pydoc_cmd = 'python -m pydoc'
" let g:pydoc_open_cmd = 'vsplit'
au BufNewFile,BufRead *.py set filetype=python
autocmd FileType python let g:pymode_run = 1
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#rename_command = "<leader>a"
let g:jedi#autocompletion_command = "<D-.>"
" let g:jedi#show_function_definition = "0"

let g:pymode_folding = 1
" let g:pymode_run_key = '<leader><leader>r'
" let g:pymode_doc_key = '<leader>k'
let g:pymode_rope = 0
" map <C-c>g :call RopeGotoDefinition()
map <C-/> :call RopeCodeAssist()<cr>
" }}}2

" => ruby and rails etc {{{2
" extra rails.vim help
autocmd User Rails silent! Rnavcommand decorator app/decorators -glob=**/* -suffix=_decorator.rb
autocmd User Rails silent! Rnavcommand observer app/observers -glob=**/* -suffix=_observer.rb
autocmd User Rails silent! Rnavcommand feature features -glob=**/* -suffix=.feature
autocmd User Rails silent! Rnavcommand job app/jobs -glob=**/* -suffix=_job.rb
autocmd User Rails silent! Rnavcommand mediator app/mediators -glob=**/* -suffix=_mediator.rb
autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb
" }}}2

" => git and gist etc {{{2
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1

" map for gitgutter
let g:gitgutter_enabled = 0
nmap <leader>g :GitGutterToggle<CR>
" }}}2

" => Set gtags and gtags-cscope {{{2
map [Gtags]1 <esc>:!gtags &<cr>

let Gtags_OpenQuickfixWindow = 0
let Gtags_Auto_Map=0

"nmap <M-[> :Gtags -gi<cr>
"nmap <M-e> :Gtags -gi<cr><cr><cr>*.[ch]<cr>
map [Gtags]2 <esc>:Gtags<cr><cr>
map [Gtags]3 <esc>:Gtags -r <cr><cr>

map [Gtags]n :cn<cr>
map [Gtags]p :cp<cr>
map [Gtags]o :Gozilla<CR>

"for cscope
if has("cscope")
" set csprg=/usr/local/bin/cscope
" set csto=1
" set cst
" set nocsverb
" " add any database in current directory
" if filereadable("cscope.out")
    " cs add cscope.out
" endif
" set csverb
endif

"inoremap  @o <ESC> :cs find c =expand("")<C-R>
"nmap c :cs find c =expand("")
nmap [Gtags]s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap [Gtags]g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap [Gtags]c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap [Gtags]t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap [Gtags]e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap [Gtags]f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap [Gtags]i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap [Gtags]d :cs find d <C-R>=expand("<cword>")<CR><CR>

"set Cscope & quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e-
"}}}2

" => vim-shareborad {{{2
" let g:shareboard_command = printf('pandoc -Ss --toc -m -c "%s"
            " \ -r markdown_strict+fenced_code_blocks
            " \ -w html5',
            " \ expand("~/Library/Application\ Support/nvALT/custom.css"))

" let g:shareboard_command = printf('pandoc -Ss --toc -m -c "%s"
            " \ -r markdown
            " \ -w html5',
            " \ expand("~/Library/Application Support/nvALT/custom.css"))
" }}}2
" }}}

" => vimrc.local{{{
if has("mac" || "unix")
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
elseif has("win32")
    if filereadable(expand("~/_vimrc.local"))
        source ~/_vimrc.local
    endif
endif
" }}}
