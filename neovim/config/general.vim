" Indentation
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set cindent

" General stuff 
set wrap
set textwidth=79
set colorcolumn=80,110
set hidden

" Search 
set hlsearch " highlight search
set ignorecase 
set smartcase " capitals in searches make them case sensitive
set showmatch " brackets
set autowrite

" Other useful stuff:
set mat=2 " seconds of blinking when matching parentheses

set modeline

" Use , instead of \ as the leader key
let mapleader = ","
let g:mapleader = ","

" Magic: type jk fast to escape insert mode
imap jk <ESC>l

" Spelling should be proper
setlocal spell spelllang=en_gb

" Preserve indentation from system clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" Fast write and save
noremap <leader>w :w!<CR>
noremap <leader>q :q!<CR>

" Window Split
noremap <leader>ws :split<CR>
noremap <leader>wv :vsplit<CR>
" Window close
noremap <leader>wc <C-W>q
