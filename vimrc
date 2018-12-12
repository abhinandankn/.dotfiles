" Vim Configuration
" Author: Abhinandan K N
" Contact: abhikn@outlook.com


" Required
set nocompatible
filetype off
filetype plugin indent on
syntax enable
set encoding=utf-8

" Keep more info in memory
set hidden
set history=100

" Vundle Plugin Manager 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'christoomey/vim-sort-motion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-line'
Plugin 'kana/vim-textobj-user'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree' 
Plugin 'kien/ctrlp.vim'

" Python Plugins
Plugin 'Townk/vim-autoclose'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'majutsushi/tagbar'
Plugin 'benmills/vimux'
Plugin 'maralla/completor.vim'
Plugin 'w0rp/ale'

" All of your Plugins must be added before the following line
call vundle#end()

" Look, Feel and Window Management 
colorscheme Tomorrow-Night-Eighties
set guifont=Inconsolata\ 18

set wildmenu
set splitright
set splitbelow

" set relative line numbers based on mode
set number relativenumber
 
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set ruler

" Auto save folds
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent loadview
augroup END

" set tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Highlight current line
set cursorline

" show matching paranthesis
set showmatch

" Set timeouts
set timeout timeoutlen=2000 ttimeoutlen=100

" Nerd tree settings
let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

" Light line settings
set laststatus=2

if !has('gui_running')
  set t_Co=256
endif

" search settings
" set hlsearch

" Key Bindings

" Map Leader key to Space
map s <Nop>
let mapleader=" "

" Keybinding to Source .vimrc
nmap <leader>S :edit ~/.vimrc<CR>
nmap <leader>s :source ~/.vimrc<CR>

" Quit and Write
nmap <leader>q :q!<CR>
nmap <leader>w :w<CR> 

" Vertical and Horizontal splits
nmap <leader>v :vsp<CR> 
nmap <leader>h :sp<CR> 

" Nerd Tree Toggle
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" Run ALEFix for Python auto formatting
noremap <F3> :ALEFix<CR>

" Compile and Run Code
nnoremap <F5> :call <SID>compile_and_run()<CR>

" Debug Python Code, Open PDB
nnoremap <F7> :
    \ call VimuxRunCommand("clear; python -m pdb " . bufname("%"))<CR>

" Toggle Folding
nmap <Tab> za

" Toggle Tagbar
nmap <leader>t :TagbarToggle<CR>

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
inoremap <expr> <Tab> Tab_Or_Complete()

" Python settings

" Code Completor
let g:completor_python_binary = '/usr/bin/python'
" ALE Async Linter
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'yapf']}
 
" Function to Run Code
function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec ""
    elseif &filetype == 'python'
        exec "VimuxRunCommand(\"clear; python3 \" . bufname(\"%\"))"
    endif
endfunction

" Auto Completor
function! Tab_Or_Complete() abort
    if pumvisible()
        return "\<C-N>"
    elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-R>=completor#do('complete')\<CR>"
    else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

