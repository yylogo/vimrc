set encoding=utf-8 " Necessary to show Unicode glyphs
" 定义快捷键的前缀，即<Leader>
let mapleader=";"

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" 让配置变更立即生效
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 显示行号
set nu

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" " vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
" 这个插件可以显示文件的Git增删状态
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/DrawIt'
Plugin 'SirVer/ultisnips'
Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'suan/vim-instant-markdown'
Plugin 'lilydjwg/fcitx.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mhinz/vim-signify'
Plugin 'davidhalter/jedi'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'dimasg/vim-mark'
" Plugin 'yylogo/auto_session'
" 插件列表结束
call vundle#end()
filetype plugin indent on
 
" 颜色设置
set background=dark
colorscheme molokai

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
endif

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
" 启动 vim 时自动全屏
autocmd VimEnter * call ToggleFullscreen()

set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
" 总是显示状态栏
set laststatus=2
let g:Powerline_symbols='unicode'
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
" 禁止折行
set nowrap

" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle
map <C-w>m <C-w>H<C-w>K

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" f.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nmap     <Leader>ff <Plug>CtrlSFPrompt -G '.*\.py' 
vmap     <Leader>ff <Plug>CtrlSFVwordPath -G '.*\.py' 
vmap     <Leader>fF <Plug>CtrlSFVwordExec -G '.*\.py' 
nmap     <Leader>fn <Plug>CtrlSFCwordExec -G '.*\.py' 
nmap     <Leader>fN <Plug>CtrlSFCwordPath -G '.*\.py' 
nmap     <Leader>fp <Plug>CtrlSFPwordPath -G '.*\.py' 
nnoremap <Leader>fo :CtrlSFOpen<CR>

let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ }
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_custom_ignore = {'dir':  '\v[\/]\.(git|hg|svn|tags)$', 'file': '\v\.(exe|so|dll|pyc|tmp|txt|moba)$'}

" 项目文件树
" Ctrl+N 打开/关闭
map <F3> :NERDTreeToggle<CR>
map <Leader>N :NERDTreeToggle<CR>
 " 当不带参数打开Vim时自动加载项目树
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当所有文件关闭时关闭项目树窗格
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
" 不显示这些文件
let NERDTreeIgnore=['\.pyc$', '\.moba', '\.tmp', '\.txt', '\~$', 'node_modules'] "ignore files in NERDTree
" 不显示项目树上额外的信息，例如帮助、提示什么的
let NERDTreeMinimalUI=1

" fish的兼容
if &shell =~# 'fish$'
    set shell=sh
endif

"""""""""""""""""""""""""""""""  
"     miniBufexplorer Config  
 """"""""""""""""""""""""""""""  
let g:miniBufExplMapWindowNavArrows = 1  
let g:miniBufExplMapWindowNavVim = 1  
let g:miniBufExplMapCTabSwitchWindows = 1  
"let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
  
"解决FileExplorer窗口变小问题  
let g:miniBufExplForceSyntaxEnable = 1  
let g:miniBufExplorerMoreThanOne=2

" 解决插入模式下delete/backspce键失效问题
set backspace=2


" 补全相关
let g:ycm_python_binary_path = '/usr/bin/python2.7'

" 项目相关
" reload脚本
function! Reload(module, ...)
    if a:0 == 1
        execute '!python ~/MobaServer/server/pubtool/quick_reload.py ' . a:module . a:{2}
    else
        execute ':!python ~/MobaServer/server/pubtool/quick_reload.py ' . a:module
    endif
endfunction

" 开服脚本
function! Kaifu(...)
    echo a:0
    if a:0 == 1
        execute '!python ~/MobaServer/server/pubtool/quick_kaifu.py debug'
        " :w !python ~/MobaServer/server/pubtool/quick_kaifu.py debug
    else
        execute '!python ~/MobaServer/server/pubtool/quick_kaifu.py '
    endif
endfunction

" command! -nargs=0 HW call Reload()
command! -n=* Reload :call Reload(<q-args>)
command! -n=* -complete=shellcmd Kaifu :call Kaifu(<f-args>)

nnoremap <leader>R :Reload 
nnoremap <leader>k :Kaifu<CR>
nnoremap <leader>d :Kaifu<space>debug<CR>

let g:ctrlsf_ignore_dir = ["log", 'local']


" 语法高亮配置
" 设置错误符号
let g:syntastic_error_symbol='✗'
" 设置警告符号
let g:syntastic_warning_symbol='⚠'
" 是否在打开文件时检查
let g:syntastic_check_on_open=0
" 是否在保存文件后检查
let g:syntastic_check_on_wq=1
let g:syntastic_python_flake8_post_args='--ignore=E501,E128,W391'


