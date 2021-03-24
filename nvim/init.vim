let g:ale_disable_lsp = 1
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/coc.vim
syntax on
set guicursor=
set nohlsearch
set hidden
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set nu
set relativenumber
set autoindent
set smartindent
set smarttab
set expandtab
set softtabstop=4
set shiftwidth=4
set mouse=a
set title
set colorcolumn=80
let mapleader = " "

nnoremap <C-Space> <esc>
inoremap <C-Space> <esc>
vnoremap <C-Space> <esc>
xnoremap <C-Space> <esc>
snoremap <C-Space> <esc>
cnoremap <C-Space> <esc>
onoremap <C-Space> <esc>
nnoremap <C-A-J> <C-W>J
nnoremap <C-A-K> <C-W>K
nnoremap <C-A-L> <C-W>L
nnoremap <C-A-H> <C-W>H
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" File Nav
nnoremap <silent><leader>n :bn<CR>
nnoremap <silent><leader>b :bp<CR>
nnoremap <silent><leader>d :bd<CR>
nnoremap <silent><leader>s :vs<CR>
nnoremap <silent><leader>o :NERDTreeToggle<CR>

colorscheme gruvbox
set background=dark

" air-line
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰ '
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.dirty='⚡'
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 0
" let g:airline#extensions#coc#enabled = 0
" ALE Settings
"
"" Shorten error/warning flags
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" Disable or enable loclist at the bottom of vim 
" Comes down to personal preferance.
let g:ale_open_list = 0
let g:ale_loclist = 0

" Setup compilers for languages

let g:ale_linters = {
      \  'cs':['syntax', 'semantic', 'issues'],
      \  'python': ['pylint'],
      \  'java': ['javac']
      \ }

"CoC Settings
"
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<c-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
