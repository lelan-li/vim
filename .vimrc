set nocompatible " 关闭 vi 兼容模式
syntax on " 自动语法高亮
colorscheme default " 设定配色方案
"colorscheme solarized" 设定配色方案
set number " 显示行号
"set cursorline " 突出显示当前行
set ruler " 打开状态栏标尺
"set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set nobackup " 覆盖文件时不备份
"set autochdir " 自动切换当前目录为当前文件所在的目录
filetype plugin indent on " 开启插件
set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
" set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=2 " 短暂跳转到匹配括号的时间
set splitbelow " 上下分割
set splitright " 左右分割
set magic " 设置魔术
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
"set guioptions-=T " 隐藏工具栏
"set guioptions-=m " 隐藏菜单栏
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start
" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
" 设置在状态行显示的信息
set foldenable " 开始折叠
set foldmethod=syntax " 设置语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
" set foldclose=all " 设置为自动关闭折叠 
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 用空格键来开关折叠
"autocmd FileType python set omnifunc=pythoncomplete#Complete "代码补全
filetype off                  "打开文件类型检测功能
set mouse=a "允许鼠标点击定位
set selection=exclusive "允许区域选择
"set selection=mousekey
set showmatch "高年显示匹配括号
filetype plugin indent on "自动补全
set encoding=utf-8 " 支持utf-8编码
set completeopt=longest,menu
set clipboard=unnamed " 可以使用系统剪切板
set wildmenu
set hlsearch " 搜索高亮
set scrolloff=3 " 距离顶部底部三行
"自动补全命令时候使用菜单式匹配列表-------
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet
" 分割窗口切换---------------------------
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 支持PEP8风格的缩进---------------------
au BufNewFile,BufRead *.py
\ set tabstop=4
\ set softtabstop=4
\ set shiftwidth=4
\ set textwidth=79
\ set expandtab
\ set autoindent
\ set fileformat=unix

" F5执行python代码-------------------------
map <F5> :call RunPython()<CR>
func! RunPython()
    exec "W"
    if &filetype == 'python'
        exec "!time python2.7 %"
    endif
endfunc
" 代码折叠----------------------------------
set foldmethod=indent
set foldlevel=99
" 使用space进行代码折叠
nnoremap <space> za 
" 希望看到折叠代码的文档字符串
let g:SimpylFold_docstring_preview=1

" start=====================================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Vundle 管理--------------------------------
Plugin 'gmarik/Vundle.vim'

" 代码折叠，防止多折------------------------
" Plugin 'tmhedberg/SimpyFold'

" 自动缩进
Plugin 'vim-scripts/indentpython.vim'

" 自动补全----------------------------------
Plugin 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1 " 自动补全窗口不会消失
" 转到定义
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> 
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
" 语法检查---------------------------------
Plugin 'scrooloose/syntastic'
" PEP8代码风格检查-------------------------
Plugin 'nvie/vim-flake8'
" 让语法变得更漂亮------------------------
let python_highlight_all=1
syntax on
" 配色方案
" Plugin 'jnurmine/Zenburn'
" Plugin 'altercation/vim-colors-solarized'
" GUI为solarized方案，终端为Zenburn方案
" if has('gui_running')
"   set background=dark
"   colorscheme solarized
" else
"   colorscheme Zenburn
" endif
" 用F5控制Solarized暗色调和轻色调切换
" call togglebg#map("<F5>")
" 文件树型展示-----------------------------
Plugin 'scrooloose/nerdtree'
" 将f2设置成开关的按键
map <f2>:NERDTreeToggle<cr> 
" 修改树的图标
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='+'
let g:NERDTreeWinPos='left' " 窗口位置
let g:NERDTreeSize=30 " 窗口尺寸
let g:NERDTreeShowLineNumbers=1 " 窗口是否显示行号
let g:NERDTreeHidden=0 " 不显示隐藏文件
" 隐藏.pyc文件
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" 超级搜索 ctrl+P---------------------------
Plugin 'kien/ctrlp.vim'
" 状态栏插件--------------------------------
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" end------------------------------------------------------------------------
call vundle#end()            " required
filetype plugin indent on    " required
" end========================================================================
