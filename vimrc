"           _                 __             _ __ 
"    _   __(_)___ ___        / /__________ _(_) /_
"   | | / / / __ `__ \______/ __/ ___/ __ `/ / __/
"   | |/ / / / / / / /_____/ /_/ /  / /_/ / / /_  
"   |___/_/_/ /_/ /_/      \__/_/   \__,_/_/\__/  
"
"   Author: ChenFuQiang (lotus.trait) <lotus.trait@gmail.com>
"   Version: 1.0
"   Created: 2024-01-01
"   Last Modified: 2024-01-01
"
"   Sections:
"     => Setting
"     => General
"     => Platform Specific Setting
"     => Vim-plug
"     => User Interface
"     => Colors and Fonts
"     => Indent Related
"     => Search Related
"     => Fold Related
"     => Key Mapping
"     => Plugin Setting
"     => Local Setting
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => Setting
"------------------------------------------------

" user setting
let g:trait_user='ChenFuQiang' " User name
let g:trait_email='lotus.trait@gmail.com' " User email
let g:trait_github='https://github.com/lotus-trait' " User github
" color settings (hybrid, gruvbox or tender)
let g:trait_default_scheme='hybrid'
" ui setting
let g:trait_fancy_font=1 " Enable using fancy font
let g:trait_show_number=1 " Enable showing number
" autocomplete setting (YCM or NEO)
let g:trait_autocomplete='YCM'
" plugin setting
let g:trait_bundle_groups=['ui', 'enhance', 'move', 'navigate',
            \'complete', 'compile', 'git', 'language']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => General
"------------------------------------------------

set nocompatible " Get out of vi compatible mode
filetype plugin indent on " Enable filetype
let mapleader=',' " Change the mapleader
let maplocalleader='\' " Change the maplocalleader
set timeoutlen=500 " Time to wait for a command

" Source the vimrc file after saving it
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" Fast edit the .vimrc file using ,x
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

nnoremap <Leader>m :make<CR>
nnoremap <Leader>co :copen<CR>:AnsiEsc<CR>
nnoremap <Leader>cc :cclose<CR>
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>lc :lclose<CR>

set autoread " Set autoread when a file is changed outside
set autowrite " Write on make/shell commands
set hidden " Turn on hidden"

set history=1000 " Increase the lines of history
set modeline " Turn on modeline
set encoding=utf-8 " Set utf-8 encoding
set completeopt+=longest " Optimize auto complete
set completeopt-=preview " Optimize auto complete

set undofile " Set undo

" Set directories
function! InitializeDirectories()
    let parent=$HOME
    let prefix='.vim'
    let dir_list={
                \ 'backup': 'backupdir',
                \ 'view': 'viewdir',
                \ 'swap': 'directory',
                \ 'undo': 'undodir',
                \ 'cache': '',
                \ 'session': ''}
    for [dirname, settingname] in items(dir_list)
        let directory=parent.'/'.prefix.'/'.dirname.'/'
        if !isdirectory(directory)
            if exists('*mkdir')
                let dir = substitute(directory, "/$", "", "")
                call mkdir(dir, 'p')
            else
                echo 'Warning: Unable to create directory: '.directory
            endif
        endif
        if settingname!=''
            exe 'set '.settingname.'='.directory
        endif
    endfor
endfunction
call InitializeDirectories()

autocmd BufWinLeave *.* silent! mkview " Make Vim save view (state) (folds, cursor, etc)
autocmd BufWinEnter *.* silent! loadview " Make Vim load view (state) (folds, cursor, etc)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Platform Specific Setting
"-------------------------------------------------

" On Windows, also use .vim instead of vimfiles
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

set viewoptions+=slash,unix " Better Unix/Windows compatibility
set viewoptions-=options " in case of mapping change
set viewoptions-=curdir " in case of mapping change

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Vim-plug
"--------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

if count(g:trait_bundle_groups, 'ui') " UI setting
    Plug 'kristijanhusak/vim-hybrid-material' " Colorscheme hybrid material
    Plug 'morhetz/gruvbox' " Colorscheme gruvbox
    Plug 'jacoborus/tender.vim' " Colorscheme tender
    Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes' " Status line
    Plug 'ryanoasis/vim-devicons'
    Plug 'Yggdroot/indentLine' " Indentation level
    Plug 'ryanoasis/vim-devicons' " Devicons
    Plug 'bling/vim-bufferline' " Buffer line
    Plug 'mhinz/vim-startify' " Start page
    Plug 'junegunn/goyo.vim', { 'for': 'markdown' } " Distraction-free
    Plug 'junegunn/limelight.vim', { 'for': 'markdown' } " Hyperfocus-writing
    Plug 'fedorenchik/AnsiEsc'
    Plug 'ryanoasis/vim-devicons'
endif

if count(g:trait_bundle_groups, 'enhance') " Vim enhancement
    Plug 'Raimondi/delimitMate' " Closing of quotes
    Plug 'tomtom/tcomment_vim' " Commenter
    Plug 'tpope/vim-abolish' " Abolish
    Plug 'tpope/vim-speeddating' " Speed dating
    Plug 'tpope/vim-repeat' " Repeat
    Plug 'terryma/vim-multiple-cursors' " Multiple cursors
    Plug 'junegunn/vim-slash' " In-buffer search
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " Undo tree
    Plug 'tpope/vim-surround' " Surround
    Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " Easy align
    Plug 'ludovicchabant/vim-gutentags' " Manage tag files
    Plug 'AndrewRadev/splitjoin.vim' " Splitjoin
    Plug 'sickill/vim-pasta' " Vim pasta
    Plug 'Keithbsmiley/investigate.vim' " Helper
    Plug 'wikitopian/hardmode' " Hard mode
    Plug 'wellle/targets.vim' " Text objects
    Plug 'roman/golden-ratio' " Resize windows
    Plug 'chrisbra/vim-diff-enhanced' " Create better diffs
endif

if count(g:trait_bundle_groups, 'move') " Moving
    Plug 'tpope/vim-unimpaired' " Pairs of mappings
    Plug 'Lokaltog/vim-easymotion' " Easy motion
    Plug 'kepbod/quick-scope' " Quick scope
    Plug 'yuttie/comfortable-motion.vim' " Comfortable motion
    Plug 'bkad/CamelCaseMotion' " Camel case motion
    Plug 'majutsushi/tagbar' " Tag bar
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  } " Fuzzy finder
    Plug 'junegunn/fzf.vim' " Fuzzy finder plugin
endif

if count(g:trait_bundle_groups, 'navigate') " Navigation
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " NERD tree
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } " NERD tree git plugin
    Plug 'mhinz/vim-tmuxify' " Tmux panes
    Plug 'vim-scripts/a.vim'
endif

if count(g:trait_bundle_groups, 'complete') " Completion
    if g:trait_autocomplete=='NEO'
        if has('lua')
            let g:trait_completion_engine='neocomplete'
            Plug 'Shougo/neocomplete.vim' " Auto completion framework
        else
            let g:trait_completion_engine='neocomplcache'
            Plug 'Shougo/neocomplcache.vim' " Auto completion framework
        endif
        Plug 'Shougo/neosnippet.vim' " Snippet engine
        Plug 'Shougo/neosnippet-snippets' " Snippets
        Plug 'Shougo/vimproc.vim', { 'do': 'make' }
        Plug 'wellle/tmux-complete.vim' " Completion for tmux panes
    else
        " Auto completion framework
        let g:trait_completion_engine='YouCompleteMe'
        Plug 'Valloric/YouCompleteMe', { 'do': './install.py' } "Auto completion framework
        Plug 'honza/vim-snippets' " Snippets
        Plug 'sirver/ultisnips' " Snippet engine
    endif
endif

if count(g:trait_bundle_groups, 'compile') " Compiling
    Plug 'scrooloose/syntastic' " Syntax checking
    Plug 'xuhdev/SingleCompile' " Single compile
endif

if count(g:trait_bundle_groups, 'git') " Git
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'junegunn/gv.vim' " Gitk clone
    if has('signs')
        Plug 'airblade/vim-gitgutter' " Git diff sign
    endif
endif

if count(g:trait_bundle_groups, 'language') " Language Specificity
    Plug 'rust-lang/rust.vim'
    Plug 'davidhalter/jedi-vim', { 'for': 'python' } " Python jedi plugin
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'tpope/vim-rails', { 'for': [] } " Rails
    Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] } " Emmet
    Plug 'LaTeX-Box-Team/LaTeX-Box' " LaTex
    Plug 'sheerun/vim-polyglot' " Language Support
"   Plug 'dense-analysis/ale'
endif

if filereadable(expand($HOME . '/.vimrc.bundles.local')) " Load local bundles
    source $HOME/.vimrc.bundles.local
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => User Interface
"-------------------------------------------------

if count(g:trait_bundle_groups, 'ui')
    let g:airline#extensions#tabline#enabled=1
else
    " Set title
    set title
    set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)

    " Set tabline
    set showtabline=2 " Always show tab line
    " Set up tab labels
    set guitablabel=%m%N:%t[%{tabpagewinnr(v:lnum)}]
    set tabline=%!MyTabLine()
    function! MyTabLine()
        let s=''
        let t=tabpagenr() " The index of current page
        let i=1
        while i<=tabpagenr('$') " From the first page
            let buflist=tabpagebuflist(i)
            let winnr=tabpagewinnr(i)
            let s.=(i==t ? '%#TabLineSel#' : '%#TabLine#')
            let s.='%'.i.'T'
            let s.=' '
            let bufnr=buflist[winnr-1]
            let file=bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            let m=''
            if getbufvar(bufnr, '&modified')
                let m='[+]'
            endif
            if buftype=='nofile'
                if file=~'\/.'
                    let file=substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file=fnamemodify(file, ':p:t')
            endif
            if file==''
                let file='[No Name]'
            endif
            let s.=m
            let s.=i.':'
            let s.=file
            let s.='['.winnr.']'
            let s.=' '
            let i=i+1
        endwhile
        let s.='%T%#TabLineFill#%='
        let s.=(tabpagenr('$')>1 ? '%999XX' : 'X')
        return s
    endfunction
    " Set tabline colorscheme
    if g:trait_default_scheme=='gruvbox'
        let g:gruvbox_invert_tabline=1
    endif
    " Set up tab tooltips with each buffer name
    set guitabtooltip=%F
endif

" Set status line
if count(g:trait_bundle_groups, 'ui')
    set laststatus=2 " Show the statusline
    set noshowmode " Hide the default mode text
    " Set status line colorscheme
    if g:trait_default_scheme=='hybrid'
        let g:airline_theme='bubblegum'
    elseif g:trait_default_scheme=='tender'
        let g:tender_airline=1
        let g:airline_theme='tender'
    endif
    set ttimeoutlen=50
    let g:bufferline_echo=0
    let g:bufferline_modified='[+]'
    if g:trait_fancy_font
        let g:airline_powerline_fonts=1
    else
        let g:airline_left_sep=''
        let g:airline_right_sep=''
    endif
endif

" Only have cursorline in current window and in normal window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline
set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Use powerful wildmenu
set shortmess=at " Avoids hit enter
set showcmd " Show cmd

set backspace=indent,eol,start " Make backspaces delete sensibly
set whichwrap+=h,l,<,>,[,] " Backspace and cursor keys wrap to
set virtualedit=block,onemore " Allow for cursor beyond last character
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor

set showmatch " Show matching brackets/parenthesis
set matchtime=2 " Decrease the time to blink

if g:trait_show_number
    set number " Show line numbers
    " Toggle relativenumber
    nnoremap <Leader>n :set relativenumber!<CR>
endif

set formatoptions+=rnlmM " Optimize format options
set wrap " Set wrap
set textwidth=80 " Change text width
if g:trait_fancy_font
    set list " Show these tabs and spaces and so on
    set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ " Change listchars
    set linebreak " Wrap long lines at a blank
    set showbreak=↪  " Change wrap line break
    set fillchars=diff:⣿,vert:│ " Change fillchars
    augroup trailing " Only show trailing whitespace when not in insert mode
        autocmd!
        autocmd InsertEnter * :set listchars-=trail:⌴
        autocmd InsertLeave * :set listchars+=trail:⌴
    augroup END
endif

" Set gVim UI setting
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Colors and Fonts
"-------------------------------------------------
"set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/

syntax on " Enable syntax
set background=dark " Set background
if !has('gui_running')
    set t_Co=256 " Use 256 colors
endif

" Use true colors
if (empty($TMUX))
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" Load a colorscheme
if count(g:trait_bundle_groups, 'ui')
    if g:trait_default_scheme=='hybrid'
        colorscheme hybrid_reverse
    elseif g:trait_default_scheme=='gruvbox'
        colorscheme gruvbox
    elseif g:trait_default_scheme=='tender'
        colorscheme tender
    endif
else
    colorscheme desert
endif

" Set GUI font
if has('gui_running')
    if has('gui_gtk')
        set guifont=DejaVu\ Sans\ Mono\ 18
    else
        set guifont=DejaVu\ Sans\ Mono:h18
    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Indent Related
"-------------------------------------------------

set autoindent " Preserve current indent on new lines
set cindent " set C style indent
set expandtab " Convert all tabs typed to spaces
set softtabstop=4 " Indentation levels every four columns
set shiftwidth=4 " Indent/outdent by four columns
set tabstop=4 " Indent/outdent by four columns
set shiftround " Indent/outdent to nearest tabstop

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Search Related
"-------------------------------------------------

set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set hlsearch " Highlight search terms
set incsearch " Find as you type search
set gdefault " turn on g flag

" Use sane regexes
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v

" Use ,Space to toggle the highlight search
nnoremap <Leader><Space> :set hlsearch!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Fold Related
"-------------------------------------------------

set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Space to toggle and create folds.
nnoremap <silent> <Space> @=(foldlevel('.') ? 'za' : '\<Space>')<CR>
vnoremap <Space> zf

" Set foldtext
function! MyFoldText()
    let line=getline(v:foldstart)
    let nucolwidth=&foldcolumn+&number*&numberwidth
    let windowwidth=winwidth(0)-nucolwidth-3
    let foldedlinecount=v:foldend-v:foldstart+1
    let onetab=strpart('          ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')
    let line=strpart(line, 0, windowwidth-2-len(foldedlinecount))
    let fillcharcount=windowwidth-len(line)-len(foldedlinecount)
    return line.'…'.repeat(' ',fillcharcount).foldedlinecount.'L'.' '
endfunction
set foldtext=MyFoldText()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Key Mapping
"-------------------------------------------------

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Navigation between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Select entire buffer
nnoremap vaa ggvGg_

" Strip all trailing whitespace in the current file
nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>
nnoremap <Leader>sq :%s/\([a-z0-9]\)\([A-Z]\)/\1_\l\2/<CR>:let @/=''<CR>
nnoremap <Leader>cq :%s/\([a-z]\)_\([a-z]\)/\1\u\2/<CR>:let @/=''<CR>

" Modify all the indents
nnoremap \= gg=G

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Plugin Setting
"--------------------------------------------------

" Setting for UI plugins
if count(g:trait_bundle_groups, 'ui')

    " => Startify
    let g:startify_session_dir=$HOME . '/.vim/session'
    let g:startify_custom_header=[
                \'           _                 __             _ __ ',
                \'    _   __(_)___ ___        / /__________ _(_) /_',
                \'   | | / / / __ `__ \______/ __/ ___/ __ `/ / __/',
                \'   | |/ / / / / / / /_____/ /_/ /  / /_/ / / /_  ',
                \'   |___/_/_/ /_/ /_/      \__/_/   \__,_/_/\__/  ']
    let g:startify_custom_footer=['', '    ChenFuQiang <lotus.trait@gmail.com> ']
    if has('gui_running')
        hi StartifyHeader  guifg=#87afff
        hi StartifyFooter  guifg=#87afff
        hi StartifyBracket guifg=#585858
        hi StartifyNumber  guifg=#ffaf5f
        hi StartifyPath    guifg=#8a8a8a
        hi StartifySlash   guifg=#585858
    else
        hi StartifyHeader  ctermfg=56
        hi StartifyFooter  ctermfg=56
        hi StartifyBracket ctermfg=90
        hi StartifyNumber  ctermfg=90
        hi StartifyPath    ctermfg=95
        hi StartifySlash   ctermfg=95
    endif

    " => Goyo & Limelight
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!

endif

" Setting for enhancement plugins
if count(g:trait_bundle_groups, 'enhance')

    " => delimitMate
    let delimitMate_expand_cr=1
    let delimitMate_expand_space=1
    let delimitMate_balance_matchpairs=1

    " => Tcomment
    " Map \<Space> to commenting
    function! IsWhiteLine()
        if (getline('.')=~'^$')
            exe 'TCommentBlock'
            normal! j
        else
            normal! A
            exe 'TCommentRight'
            normal! l
            normal! x
        endif
        startinsert!
    endfunction
    nnoremap <silent> <LocalLeader><Space> :call IsWhiteLine()<CR>

    " => Multiple cursors
    " Called once right before you start selecting multiple cursors
    if g:trait_autocomplete=='NEO'
        function! Multiple_cursors_before()
            if g:trait_completion_engine=='neocomplete'
                exe 'NeoCompleteLock'
            else
                exe 'NeoComplCacheLock'
            endif
        endfunction
        " Called once only when the multiple selection is canceled (default <Esc>)
        function! Multiple_cursors_after()
            if g:trait_completion_engine=='neocomplete'
                exe 'NeoCompleteUnlock'
            else
                exe 'NeoComplCacheUnlock'
            endif
        endfunction
    endif

    " -> Undo tree
    nnoremap <Leader>u :UndotreeToggle<CR>
    let g:undotree_SetFocusWhenToggle=1

    " => Easy Align
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

    " => Gutentags
    let g:gutentags_define_advanced_commands = 1
    let g:gutentags_modules = ['ctags', 'gtags_cscope']
    let g:gutentags_ctags_exclude = ['*.js', '*.json', 'build']
    let g:gutentags_cache_dir=$HOME . '/.vim/cache/ctags'
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " => Splitjoin
    let g:splitjoin_split_mapping = ',s'
    let g:splitjoin_join_mapping  = ',j'
    let g:splitjoin_normalize_whitespace=1
    let g:splitjoin_align=1

    " => Investigate.vim
    "nnoremap K :call investigate#Investigate()<CR>
    let g:investigate_use_dash=1

    " => EnhancedDiff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

endif

" setting for moving plugins
if count(g:trait_bundle_groups, 'move')

    " -> Tag bar
    nnoremap <Leader>t :TagbarToggle<CR>
    let g:tagbar_autofocus=1
    let g:tagbar_expand=1
    let g:tagbar_foldlevel=2
    let g:tagbar_autoshowtag=1

    " Matchit
    " Start mathit
    packadd! matchit
    " Use Tab instead of % to switch
    nmap <Tab> %
    vmap <Tab> %

endif

" Setting for navigation plugins
if count(g:trait_bundle_groups, 'navigate')

    " => NERD Tree
    nnoremap <Leader>f :NERDTreeToggle<CR>
    let g:NERDTreeHidden=1
    let NERDTreeChDirMode=2
    let NERDTreeShowBookmarks=1
    let NERDTreeShowHidden=1
    let NERDTreeShowLineNumbers=1
    let NERDTreeIgnore = ['\.o$', '\.d', '\.swp', '\.swo']
    augroup nerd_loader
        autocmd!
        autocmd VimEnter * silent! autocmd! FileExplorer
        autocmd BufEnter,BufNew *
                    \  if isdirectory(expand('<amatch>'))
                    \|   call plug#load('nerdtree')
                    \|   execute 'autocmd! nerd_loader'
                    \| endif
    augroup END

endif

" Setting for completion plugins
if count(g:trait_bundle_groups, 'complete')

    if g:trait_autocomplete=='NEO'
        " -> Neocomplete & Neocomplcache
        " Use Tab and S-Tab to select candidate
        inoremap <expr><Tab>  pumvisible() ? "\<C-N>" : "\<Tab>"
        inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
        if g:trait_completion_engine=='neocomplete'
            let g:neocomplete#enable_at_startup=1
            let g:neocomplete#data_directory=$HOME . '/.vim/cache/neocomplete'
            let g:neocomplete#enable_auto_delimiter=1
            " Use <C-E> to close popup
            inoremap <expr><C-E> neocomplete#cancel_popup()
            inoremap <expr><CR> delimitMate#WithinEmptyPair() ?
                        \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
                        \ pumvisible() ? neocomplete#close_popup() : "\<CR>"
        else
            let g:neocomplcache_enable_at_startup=1
            let g:neocomplcache_temporary_dir=$HOME . '/.vim/cache/neocomplcache'
            let g:neocomplcache_enable_auto_delimiter=1
            let g:neocomplcache_enable_fuzzy_completion=1
            " Use <C-E> to close popup
            inoremap <expr><C-E> neocomplcache#cancel_popup()
            inoremap <expr><CR> delimitMate#WithinEmptyPair() ?
                        \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
                        \ pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        endif
        " Setting for specific language
        if has('lua')
            if !exists('g:neocomplete#force_omni_input_patterns')
                let g:neocomplete#force_omni_input_patterns={}
            endif
            let g:neocomplete#force_omni_input_patterns.python=
            \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
        else
            if !exists('g:neocomplcache_force_omni_patterns')
                let g:neocomplcache_force_omni_patterns={}
            endif
            let g:neocomplcache_force_omni_patterns.python=
            \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
        endif
        autocmd FileType python setlocal omnifunc=jedi#completions
        let g:jedi#completions_enabled=0
        let g:jedi#auto_vim_configuration=0
        let g:jedi#smart_auto_mappings=0
        let g:jedi#use_tabs_not_buffers=1
        let g:tmuxcomplete#trigger=''
        " -> Neosnippet
        " Set information for snippets
        let g:neosnippet#enable_snipmate_compatibility=1
        " Use <C-K> to expand or jump snippets in insert mode
        imap <C-K> <Plug>(neosnippet_expand_or_jump)
        " Use <C-K> to replace TARGET within snippets in visual mode
        xmap <C-K> <Plug>(neosnippet_start_unite_snippet_target)
        " For snippet_complete marker
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
    else
        let g:ycm_server_python_interpreter='/usr/bin/python'
        let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
        " -> UltiSnips
        let g:UltiSnipsExpandTrigger="<C-K>"
        let g:UltiSnipsJumpForwardTrigger="<Tab>"
        let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
    endif

    " Setting info for snips
    let g:snips_author=g:trait_user
    let g:snips_email=g:trait_email
    let g:snips_github=g:trait_github

endif

" Setting for compiling plugins
if count(g:trait_bundle_groups, 'compile')

    " -> Syntastic
    let g:syntastic_check_on_open=1
    let g:syntastic_aggregate_errors=1
    let g:syntastic_auto_jump=1
    let g:syntastic_auto_loc_list=1
    if g:trait_fancy_font
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_style_error_symbol = '✠'
        let g:syntastic_warning_symbol = '∆'
        let g:syntastic_style_warning_symbol = '≈'
    endif

    " -> Singlecompile
    nnoremap <Leader>r :SingleCompileRun<CR>
    let g:SingleCompile_showquickfixiferror=1

endif

" Setting for git plugins
if count(g:trait_bundle_groups, 'git')
endif

" Setting for language specificity
if count(g:trait_bundle_groups, 'language')

    " -> Emmet
    let g:user_emmet_leader_key='<C-Z>'
    let g:user_emmet_settings={'indentation':'    '}
    let g:use_emmet_complete_tag=1

    " -> Polyglot
    let g:vim_markdown_conceal=0

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Local Setting
"--------------------------------------------------

" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand($HOME . '/.gvimrc.local'))
        source $HOME/.gvimrc.local
    endif
endif

" Use local vimrc if available
if filereadable(expand($HOME . '/.vimrc.home'))
    source $HOME/.vimrc.home
endif

if filereadable(expand($PWD. '/.vimrc.local'))
    source $PWD/.vimrc.local
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
