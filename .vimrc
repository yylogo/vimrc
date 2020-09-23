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
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" 全局搜索(IDE的Ctrl + Shift + F)
Plug 'dyng/ctrlsf.vim'

" 底栏和顶栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 头文件和C文件快速切换
Plug 'derekwyatt/vim-fswitch'


" 媲美sublime的多选插件
Plug 'terryma/vim-multiple-cursors'


" 语法补全
" Plug 'Valloric/YouCompleteMe'
" Plug 'Shougo/deoplete-clangx'
" Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'

" 书签插件，会计按键m, [, ] 为主
Plug 'kshenoy/vim-signature'

" 键盘映射, 还要看看怎么用
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'tpope/vim-fugitive'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tell-k/vim-autopep8'
Plug 'Raimondi/delimitMate'

" svn插件
Plug 'mhinz/vim-signify'
Plug 'vim-scripts/vcscommand.vim'

Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'

Plug 'scrooloose/nerdcommenter'

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

" 记住上次打开的文件的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" -------- 主题设置 --------
"solarized主题设置在终端下的设置"
let g:solarized_termcolors=256
"设置背景色"
set background=dark
colorscheme solarized


" ========================== 快捷键统一放置 ==========================

" 文件树和tags树
map <F2> :Defx <CR>
nmap <F3> :TagbarToggle <CR>

" 上下快速翻页（避免Ctrl按键
nmap <leader>j <C-d>
nmap <leader>k <C-u>
cnoremap <leader>n <C-L><C-D>

" 使用g + ]而不是Ctrl + ]，这样每次都可以直接列出所有匹配项
" 注释/取消注释

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
function SearchInSF()
    let l:my_file_type = &filetype
    if l:my_file_type == 'c'
        let l:my_file_type = 'cc'
    endif

    " exec ':CtrlSF -T '.l:my_file_type.' '.expand("<cword>").' <CR>'
endfunction
" nnoremap <Leader>sf :call SearchInSF()<CR>
nnoremap <Leader>sf :CtrlSF <CR>
nnoremap <Leader>R :!python ~/MobaServer/server/pubtool/quick_reload.py 


" 进入搜索面板
nmap     <C-N>f <Plug>CtrlSFPrompt
" 进入搜索面板，并预先输入选择的内容
vmap     <C-F>F <Plug>CtrlSFVwordPath
" 进入搜索面板，直接搜索选择的内容
vmap     <C-F>f <Plug>CtrlSFVwordExec
" 进入搜索面板，并预先输入光标下的内容
nmap     <C-F>N <Plug>CtrlSFCwordPath
" 进入搜索面板，并搜索光标下的内容
nmap     <C-F>n <Plug>CtrlSFCwordExec
" 打开上次的搜索结果
nnoremap <C-F>o :CtrlSFToggle<CR>

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


" 代码浏览快捷键（pycharm的快捷键）
nmap <C-h> :po<cr>
" 代码浏览快捷键（pycharm的快捷键）
nmap <C-l> :ta<cr>
" 代码浏览快捷键
nmap <Leader>h :po<cr>
" 代码浏览快捷键
nmap <Leader>l :ta<cr>
" 代码浏览快捷键
nmap <Leader>] g]
"
" Leaderf 默认有<Leader>f 全局搜索文件， <Leader>b 搜索一打开的buffer

" 在命令行输入:e %%就可以代表当前编辑文件的目录
" cnoremap <expr> %% getcmdtype()==':'?expand('%:h').'/':'%%'

let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-j>'
let g:multi_cursor_select_all_word_key = '<C-a>'
" let g:multi_cursor_start_key           = '<Leader>mgs'
" let g:multi_cursor_select_all_key      = '<Leader>mga'
let g:multi_cursor_next_key            = '<C-j>'
let g:multi_cursor_prev_key            = '<C-k>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


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
endfunction

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
      \ 'toggle': 1,
      \ 'columns': 'icon:indent:icons:filename',
      \ 'resume': 1,
      \ 'root_marker': '≡ ',
      \ 'ignored_files':
      \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
      \   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
      \ })


" --------- CtrlSF --------
let g:ctrlsf_context = '-B 5 -A 3'
let g:ctrlsf_selected_line_hl = 'op'
let g:ctrlsf_auto_preview = 1
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_extra_backend_args = {
    \ 'pt': '--home-ptignore'
    \ }


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
" 显示颜色
set t_Co=256
" 永远显示状态栏
set laststatus=2
" 支持 powerline 字体
let g:airline_powerline_fonts = 1
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#enabled = 1
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中buffer显示编号
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline_theme='solarized dark'
let g:airline_theme="base16"
let g:airline_solarized_bg='light'
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


" -------- Leaderf --------
let g:Lf_ShowRelativePath = 0
let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_StlColorscheme = 'popup'
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
let g:Lf_IgnoreCurrentBufferName = 1
" let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_UseVersionControlTool = 0
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git', '.hg'],
        \ 'file': ['*.vcxproj','*.vcproj','*.lib','*.bak','*.exe','*.o','*.so','*.py[co]', '*.obj']
        \}
" autocmd BufNewFile,BufRead X:/yourdir* let g:Lf_WildIgnore={'file':['*.pyc',],'dir':['tags']}

let g:Lf_WindowPosition = 'popup'
let g:Lf_AutoResize = 1
let g:Lf_PopupWidth = 0.7520
let g:Lf_PopupShowStatusline = 0
let g:Lf_PopupPosition = [8, 35]

let g:Lf_PreviewInPopup = 1
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_PopupColorscheme = 'gruvbox_default'


" -------- tagbar --------
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }
let g:tagbar_left=1
let g:tagbar_width = 32
let g:tagbar_compact=1

" -------- 自动补全 --------
let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0
