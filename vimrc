""" Auto Installation

  if empty(glob("~/.vim/autoload/plug.vim"))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    auto VimEnter * PlugInstall
  endif

  if empty(glob("~/.vim/colors/seoul256.vim"))
    silent !curl -fLo ~/.vim/colors/seoul256.vim --create-dirs
          \ https://github.com/junegunn/seoul256.vim/raw/master/colors/seoul256.vim
  endif

  if empty(glob("~/.vim/colors/onedark.vim"))
    silent !curl -fLo ~/.vim/colors/onedark.vim --create-dirs
          \ https://github.com/joshdick/onedark.vim/raw/master/colors/onedark.vim
  endif

  if empty(glob("~/.vim/colors/lucius.vim"))
    silent !curl -fLo ~/.vim/colors/lucius.vim --create-dirs
          \ https://raw.githubusercontent.com/bag-man/dotfiles/master/lucius.vim
  endif
  
  if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
  endif

""" Appearance

  syntax on
  set number relativenumber
  set nowrap

  "colorscheme seoul256
  colorscheme lucius
  LuciusDarkLowContrast

  set cindent            " C style indent, supposely to be smarter and autoindent and smartindent
  set expandtab          " Absolutely no tabs in files
  set shiftwidth=2       " Number of spaces to use for (auto)indent step
  set softtabstop=2      " Number of spaces that <Tab> uses while editing

  set laststatus=2
  set statusline=%F
  set wildmenu
  set showcmd

  match Delimiter /\d\ze\%(\d\d\%(\d\{3}\)*\)\>/

""" Key modifiers

  set pastetoggle=<F2>
  map <F3> :F <C-r><C-w><Cr>
  map <F5> :make!<cr>
  map <F6> :set hlsearch!<CR>

  map <Cr> O<Esc>j       " Better enter key

  map Y y$
  map H ^
  map L $

  nnoremap J :tabprev<CR>
  nnoremap K :tabnext<CR>

  nnoremap M J
  nnoremap S "_diwP

  map "p vi"p
  map 'p vi'p
  map (p vi(p
  map )p vi)p

  map q: :q
  map n nzz
  xnoremap p "_dP
  cmap w!! w !sudo tee > /dev/null %

  map <C-l> :bn<Cr>
  map <C-h> :bp<Cr>
  cmap bc :Bclose<Cr>

  nnoremap <tab> :tabnext<CR>
  nnoremap <s-tab> :tabprev<CR>
  nnoremap <C-t> :tabnew<CR>
  inoremap <C-t> <Esc>:tabnew<CR>i

  noremap gt <C-w>gf
  noremap gs <C-w>vgf
  noremap gi <C-w>f
  noremap <C-]> <C-w><C-]><C-w>T

"  inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"  inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
"  inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))
  
  imap <Tab> <C-X><C-F>
  imap <s-Tab> <C-X><C-P>

  map cp :CopyRelativePath<Cr>
  map gp :Sprunge<cr>
  map go :Google<cr>
  map gl :Gblame<Cr>
  map gb :Gbrowse!<Cr>
  map ch :Gread<Cr>

  nnoremap <Space> za

  map Od <C-w>>
  map Oc <C-w><
  map Oa <C-w>+ 
  map Ob <C-w>-

""" Behaviour modifiers

  set undofile
  set undodir=~/.vim/undodir
  set clipboard=unnamed
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  set foldmethod=marker
  set backspace=indent,eol,start

"  autocmd BufWritePre *.erb,*.scss,*.rb,*.js,*.c,*.py,*.php :%s/\s\+$//e

  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

  set ignorecase
  set incsearch
  set smartcase
  set scrolloff=10
  set hlsearch!

  set wildmode=longest,list,full
  set completeopt=noselect,menuone,preview      "longest,menuone

  setlocal spell spelllang=en
  nmap ss :set spell!<CR>
  set nospell
  autocmd FileType gitcommit setlocal spell

  let g:tex_flavor = 'tex'
  autocmd FileType markdown,tex 
    \ setlocal spell wrap |
    \ map j gj |
    \ map k gk |
   
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction

  " Pared with .tmux.conf config for navigation in tmux and vim
  " {{{
  function! TmuxMove(direction)
    let wnr = winnr()
    silent! execute 'wincmd ' . a:direction
    " If the winnr is still the same after we moved, it is the last pane
    if wnr == winnr()
      call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
    end
  endfunction

  nnoremap <silent> <c-h> :call TmuxMove('h')<cr>
  nnoremap <silent> <c-j> :call TmuxMove('j')<cr>
  nnoremap <silent> <c-k> :call TmuxMove('k')<cr>
  nnoremap <silent> <c-l> :call TmuxMove('l')<cr>
  " }}}

  " complete settings
  set wildmode=longest,list,full
  set completeopt=longest,menuone

  " auto highlight current word under cursor
  " {{{
  set updatetime=10 " Short updatetime so the CursorHold event fires fairly often

  function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]' 
      exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/' 
    else 
      match none 
    endif
  endfunction

  autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()
  " }}}

  " Quickly edit/reload this configuration file
  nnoremap gev :e $MYVIMRC<CR>
  nnoremap gsv :so $MYVIMRC<CR>

  " Auto reload vimrc file upon save
  if has ('autocmd') " Remain compatible with earlier versions
    augroup vimrc     " Source vim configuration upon save
      autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
      autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
  endif " has autocmd

""" Plugins

  call plug#begin('~/.vim/plugged')
  filetype plugin indent on

  Plug 'scrooloose/nerdtree'                                           " File tree browser
  Plug 'jistr/vim-nerdtree-tabs'                                       " NerdTree independent of tabs
  Plug 'Xuyuanp/nerdtree-git-plugin'                                   " NerdTree git plugin
  Plug 'tpope/vim-commentary'                                          " Comment out blocks
  Plug 'Valloric/YouCompleteMe'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'vim-erlang/vim-erlang-runtime'
  Plug 'vim-erlang/vim-erlang-omnicomplete'
  Plug 'vim-erlang/vim-erlang-compiler'

  call plug#end()

  " NERDTree
  map <C-n> :NERDTreeTabsToggle<CR>
  map <C-f> :NERDTreeFind<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  let NERDTreeChDirMode=2
  let g:NERDTreeDirArrowExpandable = '├'
  let g:NERDTreeDirArrowCollapsible = '└'
  let g:NERDTreeMapActivateNode = '<tab>'
  set mouse=a

  " UltiSnips
  let g:UltiSnipsExpandTrigger="<c-h>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsSnippetsDir="/Users/ian/.vim/plugged/vim-snippets/snippets"

  " YouCompleteMe
  let g:ycm_key_list_select_completion = ['<TAB>']
  let g:ycm_key_list_previous_completion = ['<S-TAB>']
  let g:ycm_autoclose_preview_window_after_completion=1
  let g:ycm_python_binary_path = 'python'
