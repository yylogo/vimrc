" ========================== 插件选择 ==========================
call plug#begin('~/.vim/plugged')

" 主题
Plug 'ryanoasis/vim-devicons' 
Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'
" defx文件树
if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' } 
else
    Plug 'Shougo/defx.nvim' 
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc' 
endif
Plug 'kristijanhusak/defx-icons' 
" 模糊检索
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } 
" 自动生成索引
Plug 'ludovicchabant/vim-gutentags'
" 标签浏览
Plug 'liuchengxu/vista.vim'
" 全局搜索(IDE的Ctrl + Shift + F)
Plug 'dyng/ctrlsf.vim' 
" 底栏和顶栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' 
" 头文件和C文件快速切换
Plug 'derekwyatt/vim-fswitch' 
" 媲美sublime的多选插件
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" 语法补全
Plug 'davidhalter/jedi-vim'
Plug 'Valloric/YouCompleteMe'
" 语法检查
" Plug 'dense-analysis/ale'
" 书签插件，会计按键m, [, ] 为主
Plug 'yylogo/vim-mark'
Plug 'kshenoy/vim-signature' 
" 键盘映射,  TODO: 还要看看怎么用
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Python自动格式化插件
Plug 'tell-k/vim-autopep8'
" vim内部集成git
Plug 'tpope/vim-fugitive'
" C++显示增强
" Plug 'octol/vim-cpp-enhanced-highlight'
" tab对齐显示工具
Plug 'Yggdroot/indentLine'
" 标签标记工具
Plug 'mhinz/vim-signify'
" 自动注释插件
Plug 'scrooloose/nerdcommenter'
" 启动管理
Plug 'mhinz/vim-startify'

" VCS工具 TODO：了解怎么快速浏览diff并且提交
Plug 'vim-scripts/vcscommand.vim'
" 一个基础库
Plug 'inkarkat/vim-ingo-library'
" 括号彩虹
Plug 'luochen1990/rainbow'
" yapf
Plug 'pignacio/vim-yapf-format'
" 自动格式化
Plug 'vim-autoformat/vim-autoformat'


call plug#end()


" ========================== vim基本配置 ==========================
" 设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" 定义快捷键
let mapleader=';'
" 开启文件识别功能
filetype plugin indent on
" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替代默认方案
syntax on
" 显示行号
set nu
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
" 用空格替代tab
set expandtab
" 搜索结果高亮
set hls
" 开启搜索实时模式
set incsearch
" 关闭兼容模式
set nocompatible
" vim 自身命令的模式智能补全
set wildmenu
" 可以删除字符，可以直接删除\n这些
set backspace=indent,eol,start

" 设置搜索时忽略大小写
set ignorecase
" 高亮显示光标所在的行和列
set cursorline
set cursorcolumn
set fileformat=unix "设置以unix的格式保存文件"
set cindent     "设置C样式的缩进格式"
set mouse=a     "启用鼠标"

" 自定义光标样式
highlight CursorLine cterm=NONE ctermbg=black ctermfg=brown guibg=NONE guifg=NONE
highlight CursorColumn cterm=NONE ctermbg=black ctermfg=brown guibg=NONE guifg=NONE
" 设定行首tab为灰色
highlight LeaderTab guifg=#666666
" 输入的命令显示出来
set showcmd
" 显示光标当前位置
set ruler
" 不折行
set nowrap
" 设置双字宽度，否则无法完整显示特殊符号
set ambiwidth=double
" 显示颜色
set t_Co=256
" 永远显示状态栏
set laststatus=2
" 刷新时间设置为500ms，（默认4000ms
set updatetime=500


" 记住上次打开的文件的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" -------- 主题设置 --------
"solarized主题设置在终端下的设置"
let g:solarized_termcolors=256
"设置背景色"
set background=dark
colorscheme solarized8

" 在最后一个非隐藏缓冲区退出后则退出vim
function! s:check_exit() abort
    let l:close_mark = 1
    for i in range(1, winnr('$'))
        let l:buf_idx = winbufnr(i)
        if l:buf_idx == -1
            continue
        endif
        if getbufvar(l:buf_idx, '&filetype') == 'startify'
            let l:close_mark = 0
            break
        endif
        if buflisted(l:buf_idx)
            let l:close_mark = 0
            break
        endif
    endfor
    if l:close_mark == 1
        windo quit
    endif
endfunction
autocmd BufEnter * call s:check_exit()

" ========================== 快捷键统一放置 ==========================

" nvim兼容设置
if has('nvim')
	map <S-Insert> <C-R>+
	map! <S-Insert> <C-R>+
	imap <S-Insert> <C-R>+
	map <Home> ^  
	imap <Home> <Esc>^i  
	map <End> $
	imap <End> <Esc>$i
endif
" 文件树和tags树
map <silent> <F2> :Defx -search=`expand('%:p')` -no-focus -toggle <CR>
nmap <silent> <F3> :Vista!! <CR>
" 上下快速翻页（避免Ctrl按键
nmap <leader>j <C-d>
nmap <leader>k <C-u>
" 在命令模式的补全功能
cnoremap <leader>n <C-L><C-D>
" cscope的配置
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" 使用 ctrlsf.vfiletypeim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>R :!python ~/MobaServer/server/pubtool/quick_reload.py 

nnoremap <Leader>pf :CtrlSF <CR>
" 打开上次的搜索结果
nnoremap <leader>pp :CtrlSFToggle<CR>
nnoremap <leader>p :CtrlSF 
" 进入搜索面板，并预先输入选择的内容
vmap     <leader>pF <Plug>CtrlSFVwordPath
" 进入搜索面板，直接搜索选择的内容
vmap     <leader>pf <Plug>CtrlSFVwordExec

" 使用Leaderf查找定义Search defination
" nnoremap <Leader>sd :Leaderf gtags --all<CR>
nmap <leader>b :Leaderf! buffer<Cr>
" 跳转.c文件和.h文件
nmap <silent> <Leader>sw :FSHere<cr>

" <C-C>, <ESC> : 退出 LeaderF. 
" <C-R> : 在模糊匹配和正则式匹配之间切换
" <C-F> : 在全路径搜索和名字搜索之间切换
" <Tab> : 在检索模式和选择模式之间切换
" <C-J>, <C-K> : 在结果列表里选择
" <C-X> : 在水平窗口打开
" <C-]> : 在垂直窗口打开
" <C-T> : 在新标签打开
" <C-P> : 预览结果

" 设置tab键映射"
nmap <tab> :bn<cr>
" 设置Shift - tab键映射"
nmap <S-tab> :bp<cr>
nmap <leader>s :term<cr>

" 代码浏览快捷键（pycharm的快捷键）
nmap <C-h> :po<cr>
" 代码浏览快捷键（pycharm的快捷键）
nmap <C-l> :ta<cr>
" 代码浏览快捷键
nmap <Leader>h :po<cr>
" 代码浏览快捷键
nmap <Leader>l :ta<cr>
" 代码浏览快捷键
" 使用g + ]而不是Ctrl + ]，这样每次都可以直接列出所有匹配项
nmap <Leader>] g]

" Leaderf 默认有<Leader>f 全局搜索文件， <Leader>b 搜索一打开的buffer
" 在命令行输入:e %%就可以代表当前编辑文件的目录
" cnoremap <expr> %% getcmdtype()==':'?expand('%:h').'/':'%%'

map <Leader>ss :YapfFullFormat<CR>

" ========================== 插件统一配置 ==========================
" -------- Defx --------
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
    nnoremap <silent><buffer><expr> <CR>
    \ defx#is_directory() ?
    \ defx#do_action('open_or_close_tree') :
    \ defx#do_action('drop')
    " \ defx#do_action('multi', ['drop', 'quit'])
    nnoremap <silent><buffer><expr> E defx#do_action('drop')
    nnoremap <silent><buffer><expr> l defx#do_action('open')
    nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
    nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N defx#do_action('new_file')
    " nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
    " nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
    " nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
    " nnoremap <silent><buffer><expr> d defx#do_action('remove')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    " nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
    " nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    " nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    " nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    " nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
    nnoremap <silent><buffer><expr> c defx#do_action('copy')
    nnoremap <silent><buffer><expr> m defx#do_action('move')
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> P defx#do_action('preview')
endfunction
" defx搜索当前文件
map <silent> <leader>dd :Defx -no-focus -search=`expand('%:p')` <CR>
" 设置图标
call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })
call defx#custom#column('filename', {
      \ 'min_width': 40,
      \ 'max_width': 40,
      \ })
call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ })
call defx#custom#option('_', {
      \ 'winwidth': 35,
      \ 'split': 'vertical',
      \ 'direction': 'botright',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'defxplorer',
      \ 'root_marker': '≡ ',
      \ 'ignored_files':
      \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
      \   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp,*.log,*.un~'
      \ })
      " 'resume': 1,
let g:defx_icons_enable_syntax_highlight = 1

" --------- Vim-Mark --------
" 原插件的映射占用按键太多了，统一增加了一个前缀
let g:mwIgnoreCase = 0
let g:mwKeyMapPrefix = 'm'

" --------- CtrlSF --------
let g:ctrlsf_context = '-B 5 -A 3'
let g:ctrlsf_selected_line_hl = 'op'
let g:ctrlsf_auto_preview = 1
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_populate_qflist = 1
" let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_auto_focus = {
    \ 'at': 'start'
    \ }
let g:ctrlsf_extra_backend_args = {
    \ 'pt': '--home-ptignore'
    \ }
let g:ctrlsf_ignore_dir = ['res']

" ------- Cscope --------
if has("cscope")
    set csprg=/usr/bin/cscope
    set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    set cst                            " 同时搜索cscope数据库和标签文件
    " check cscope for definition of a symbol before checking ctags:
    set csto=1 " set to 1 if you want the reverse search order.
    if filereadable("cscope.out")
        cs add cscope.out
        " else add the database pointed to by environment variable
    elseif $CSCOPE_DB !=""
        cs add $CSCOPE_DB
    endif
    set cscopequickfix=s-,c-,d-,i-,t-,e-    " 使用QuickFix窗口来显示cscope查找结果
    " show msg when any other cscope db added
    set cscopeverbose
endif

" -------- vim-airline --------
" 支持 powerline 字体
if has('nvim')
    let g:airline_powerline_fonts = 0
else
    let g:airline_powerline_fonts = 1
endif
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#enabled = 1
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中buffer显示编号
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline_theme='solarized dark'
if has('nvim')
    let g:airline_theme="base16"
    let g:airline_solarized_bg='light'
else
    let g:airline_theme="solarized"
    let g:airline_solarized_bg='dark'
endif
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

" airline 显示项的配置
" let g:airline_section_a                        = ''
let g:airline_section_b                        = ''
let g:airline_section_c                        = ''
" let g:airline_section_gutter                   = ''
" let g:airline_section_x                        = ''
let g:airline_section_y                        = ''
let g:airline_section_z                        = ''
" let g:airline_section_warning                  = ''
" let g:airline_section_error                  = ''

" -------- gutentags --------
let g:Lf_CacheDirectory = expand('~')
let g:gutentags_cache_dir = expand(g:Lf_CacheDirectory.'/.LfCache/gtags')
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

let g:gutentags_modules = ['gtags_cscope']
let g:gutentags_define_advanced_commands = 1
let g:gen_tags#verbose = 1

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 1

let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

set cscopetag                  " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope'   " 使用 gtags-cscope 代替 cscope

set statusline+=%{gutentags#statusline()}
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call airline#update_statusline()
    autocmd User GutentagsUpdated call airline#update_statusline()
augroup END


" -------- Leaderf --------
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsHigherThan6_6_2 = 0
" let g:Lf_GtagsSource= 0
" let g:Lf_GtagsfilesCmd = {
    "\ '.git': 'git ls-files --recurse-submodules',
    "\ '.hg': 'hg files',
    "\ 'default': 'svn list -R | grep "\.py\$"',
    "\}
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_Gtagsconf = '~/.globalrc'

let g:Lf_ShowRelativePath = 0
let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_StlColorscheme = 'popup'
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_RootMarkers = ['.git', '.hg', '.svn']
let g:Lf_UseVersionControlTool = 0
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git', '.hg', 'res', 'res_tool', 'packer_mtl', 'packer_ad64', 'packer', 'nxdoc', 'bin*', 'data', 'Documents', 'venv'],
        \ 'file': ['*.vcxproj','*.vcproj','*.lib','*.bak','*.exe','*.o','*.so','*.pyc', '*.obj', '*.log', '*.md', 'tags', '*.png', '*.html', '*.json', '*.dds', '*.dll', '*.bnk', '*.txt', '*.tcl', '*.bat',
                    \ '*.zip', '*.doc', '*.nxs', '*.gim', '*.mesh', '*.mtg', '*.xlsx', '*.pyo'],
        \}
" 客户端用的
" 'res', 'ui_project', 'stat_tools', 'packer_mtl', 'packer_ad64', 'packer', 'nxdoc', 'bin*', 'data', 'Documents'
" autocmd BufNewFile,BufRead X:/yourdir* let g:Lf_WildIgnore={'file':['*.pyc',],'dir':['tags']}
let g:Lf_WindowPosition = 'popup'
let g:Lf_AutoResize = 1
let g:Lf_PopupWidth = 0.7520
let g:Lf_PopupShowStatusline = 0
let g:Lf_PopupPosition = [7, 35]
let g:Lf_PreviewInPopup = 1
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_PopupColorscheme = 'gruvbox_default'
let g:Lf_RgConfig = [
    \ "--max-columns=150",
    \ "--glob=!tags",
    \ '-g "*.{py,c,h}"',
\ ]
let g:Lf_MaxCount = 0
" let g:Lf_RememberLastSearch = 1
let g:Lf_ShortcutB = 0

" -------- vista 标签浏览器 --------
" 启用悬浮窗预览
let g:vista_echo_cursor_strategy ='floating_win'
" 侧边栏宽度.
let g:vista_sidebar_width = 30
" 设置为0，以禁用光标移动时的回显.
let g:vista_echo_cursor = 1
" 当前游标上显示详细符号信息的时间延迟.
let g:vista_cursor_delay = 400
" 跳转到一个符号时，自动关闭vista窗口.
let g:vista_close_on_jump = 0
"打开vista窗口后移动到它.
let g:vista_stay_on_open = 0
" 跳转到标记后闪烁光标2次，间隔100ms.
let g:vista_blink = [2, 100]
" 展示样式
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_position = 'vertical topleft'
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" -------- jedi-vim 自动补全 --------
" let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1

" -------- ale 语法检查 --------
"  用YCM的即可
"let g:ale_set_highlights = 1
"let g:ale_set_signs = 0
"let g:ale_lint_on_enter = 1
"let g:airline#extensions#ale#enabled = 1
"let g:ale_lint_on_text_changed = 'always'
"let g:ale_warn_about_trailing_blank_lines = 0
"let g:ale_warn_about_trailing_whitespace = 0

" -------- 打开启动 --------
let g:startify_change_cmd = 'cd'
let g:startify_change_to_vcs_root = 1
let g:startify_change_to_dir = 1
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ ]
" 感觉文件就够用了
" \ { 'type': 'sessions',  'header': ['   Sessions']       },
let g:startify_custom_header = [
	\ "                                                                          syyysssoooyddmmmmmmmNmNNNNNNNNmNNNNNmmmmmNNNNNNNNNNNNNmNNNNNNNMMMNNNmhssssssssss",
	\ '                                                                          osssssosyhdmmmmmmmmmmmNNNNNNNNNNmmmmmmmmNNNNNNNNNmNNNNNNNNNNNNMMMNNMNmyssssssssy',
	\ '                                                                          ossssssydmmmmmmdhhhhdNNmmNNmmmmddhhdmmmmmmmmmmNNNNNNNNNNNNNNNNMMMNNNNNdsssooosyy',
	\ '                                                                          ossssoohmmmmmdho+ooshddhhhyhhysssossddddmddmmmNNNNmmmmmNNNNNNMMMMNNNNNdysooooosy',
	\ '                                                                          oossoosmNNmmys/::://oooo+++o+//////oyyshdyhdmmmmNNhhhdmNNNNNNNMMMMNNNNmhssoooosy',
	\ '                                                                          +++ooshmNmys+/------:::::::::---::::///+++oyyhhddhsssyhdmmNNNNMMMMMNNNNhsssssyyy',
	\ '                                                                          ///+oshmms:::---.....----------------::///++ooooo++++osyhdmNNNNMMMMMNNNdssyyyhhy',
	\ '                                                                          //++oydmh::----..................-----::::///////////++oyhdmNNNNMMMMNNmdyyyyyyyy',
	\ '                                                                          ++oosydmo:----.......................----::::::///////+osyddmmNNNNNMNNmdhhysssyy',
	\ '                                                                          ooossyhd/:/+++++/:-..............--://++++++//////////++oshddmmNNNNNNmmhhyyyyyyh',
	\ '                                                                          sssssshh/+sssssssys+:-.......--/+osyyyyhhyyssoo+//////+++osyhdmmNNNNmmmhyyyyyyhh',
	\ '                                                                          ssssssyy///::----:///:---.---:///////////+++ooooo///////++oshdmmmmmmmmdyyssyyyyy',
	\ '                                                                          yyssssys-::-......--::--..---:/:---.....--:///+++/////////+oydmmmmmmmdhyyssyyyyy',
	\ '                                                                          ssssyyy+---://-+so+:----....://:-----////::://///////:::///oydmmmmmddhhyyyyyhhyy',
	\ '                                                                          ossyyss/-.-//:./hdh/---..`.-//::-/o/-ymmhosoo++//:::::::::/oydmmddhhysssyyyyyyyy',
	\ '                                                                          ossssoo/.......--:--..-...-://:--::---///://///::-::::::://+ydddhys+/////syyyyyy',
	\ '                                                                          oosooo+:......---.......`.-::::----::::::::---------::::://+shhyo+++/+++//yyyyyy',
	\ '                                                                          ooooo++:..````.........`.-::::::-...--------...----::::////+osooo+o///o+/:yyyyyy',
	\ "                                                                          sooo+++/..````````....``.-:////:-..............---::////////+++oo+++//o+/+yhhyyy",
	\ '                                                                          soooooo/-...``````...``..--::://-...````.....----::///////////+oo+++//+/oyyyyyyy',
	\ '                                                                          ooooooso-.-..```..---..-://:::/+/--.......----::::////++/////++o+++//+/oyyyyyyyy',
	\ '                                                                          oooossss--........-//:/+oooooooo/::-..-------:://////++++////oo+/////-:+osyhhyyy',
	\ '                                                                          osssssss:-......--.-::/++++++++//::--------:::////////+++/////::://::---.--/syyy',
	\ '                                                                          ssssssss/-.....--------::::///////::----:::::://////////++///::::::/::-..````-+s',
	\ '                                                                          sssssssso--....-/++/++///+++++++ooo+/:-:::::/://///////+++/--/:-..-:-.```````  `',
	\ '                                                                          sssssssss/--...-:://////++++oosssso+/--:::::///////+//////-.::.  ``.-------...``',
	\ '                                                                          ssssssssso/--..--..---:///////////:::--:::://////+++++++/:-:/.`  ````-::---.....',
	\ '                                                                          sssssssssso/:--......-----------::---::///////++++++++++//:/-.`````   `..---....',
	\ '                                                                          ssssssssssso+/:-............------::::////+++++++++++++++/+:.``````       ``....',
	\ '                                                                          ssssssssssso/--::---..--.-----::::://++++++ooooooooooo+++o:.```````          `.:',
	\ '                                                                          ssssssssso/-:.`.-.-:::::::::///++++ooooooooooooooooooo++o:.````````             ',
	\ '                                                                          sssssssso-`:o...: ``/ooooosssssssssssooooooooooooo+++oo+-.`````````             ',
	\ '                                                                          ssssoooo- `-/``/- `./h+/++ooooosooooooo+++++++++++++oo/.``````````              ',
	\ '                                                                          ooooooo/  `````/``:/+hh+///////////++++++++++++++++o+-.`````````````            ',
	\ '                                                                          ooooooo-     `.:``:+ohds////:::://////////////+++++-.`````````  ````      ``````',
	\ '                                                                          oo+++++.     `.:-.-oshdd+/////:///////////////+++/.```````````  ``     ````     ',
	\ '                                                                          :::::::      `.:/-./shmm+/://////////////::///++-``````````````  ```````        ',
    \ "                                                               +---------------------------------------------------------------------------------------------------+",
    \ "                                                               |                                      zhangqingyang@corp.netease.com                               |",
    \ "                                                               +-------------------------------------------------+-------------------------------------------------+",
	            \]
let g:startify_custom_footer = [ ]

" -------- rainbow 括号彩虹 --------
let g:rainbow_active = 1
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

" -------- vim-signify --------
" let g:signify_sign_change_delete = 1

" -------- YCM --------
"let g:ycm_global_ycm_extra_conf=g:Lf_CacheDirectory.'/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments = 1 "在注释输入中也能补全
let g:ycm_complete_in_strings = 1 "在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0 "注释和字符串中的文字也会被收入补全
let g:ycm_max_num_identifier_candidates = 50
let g:ycm_auto_trigger = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>'
let g:ycm_always_populate_location_list = 0


" -------- vim-cpp-enhanced-highlight --------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

" -------- autoformat --------
"nnoremap <leader>lf :call FormatCode("", "file")<CR>
"vnoremap <leader>lf :call FormatCode(visualmode(), "file")<CR>
nnoremap <leader>gf :call FormatCode("", "Google")<CR>
vnoremap <leader>gf :call FormatCode(visualmode(), "Google")<CR>
"nnoremap <leader>cf :call FormatCode("", "Chromium")<CR>
"vnoremap <leader>cf :call FormatCode(visualmode(), "Chromium")<CR>
"nnoremap <leader>lf :call FormatCode("", "LLVM")<CR>
"vnoremap <leader>lf :call FormatCode(visualmode(), "LLVM")<CR>

func! FormatCode(exe_mode, style) range
  if a:exe_mode == ""
    let firstline_no = 1
    let lastline_no = line("$")
  else
    let firstline_no = a:firstline
    let lastline_no = a:lastline
  endif
  let l:save_formatdef = g:formatdef_clangformat
  let l:tmpa = join(["clang-format --lines=", firstline_no, ":", lastline_no], "")
  let g:formatdef_clangformat = "'" . l:tmpa . " --assume-filename=' . bufname('%') . ' -style=" . a:style . "'"
  let formatcommand = ":Autoformat"
  exec formatcommand
  let g:formatdef_clangformat = l:save_formatdef
endfunc

