if &compatible
  set nocompatible
endif
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

filetype off

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('scrooloose/syntastic')
  call dein#add('derekwyatt/vim-scala')
  call dein#add('ensime/ensime-vim')
  call dein#add('elmcast/elm-vim')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

source $HOME/.config/nvim/config/general.vim

" Standard config 
filetype plugin indent on
syntax on


" Use , instead of \ as the leader key
let mapleader = ","
let g:mapleader = ","

" Magic: type jk fast to escape insert mode 
imap jk <ESC>l

" Odd solarized things
"
let g:solarized_termtrans = 1
let g:solarized_termcolors=256

colorscheme solarized
if has('gui_running')
  set background=light
else
  set background=dark
endif
call togglebg#map("<F5>")


" Setup airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'


" Spelling should be proper
setlocal spell spelllang=en_gb


" Preserve indendation from system clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>


" Fast write and save
noremap <leader>w :w!<CR>
noremap <leader>q :q!<CR>

