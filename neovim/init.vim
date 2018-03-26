if &compatible
  set nocompatible
endif
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

filetype off

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Boilerplate
  call dein#add('tpope/vim-sensible')

  " appearance
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('fatih/molokai')
  

  " completion
  call dein#add('Shougo/denite.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
  call dein#add('sirver/UltiSnips')
  call dein#add('honza/vim-snippets')

  " tpope
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-commentary')
  
  " syntax etc.
  call dein#add('scrooloose/syntastic')
  call dein#add('derekwyatt/vim-scala')
  call dein#add('ensime/ensime-vim')
  call dein#add('elmcast/elm-vim')
  call dein#add('sheerun/vim-polyglot')

  " golang
  call dein#add('fatih/vim-go')
  call dein#add('zchee/deoplete-go', {'build': 'make'})

  " formatting
  call dein#add('sbdchd/neoformat')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


" Standard config
filetype plugin indent on
syntax on

source $HOME/.config/nvim/config/general.vim

" Use , instead of \ as the leader key
let mapleader = ","
let g:mapleader = ","


" Magic: type jk fast to escape insert mode
imap jk <ESC>l


let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai
if has('gui_running')
  set background=light
else
  set background=dark
endif
call togglebg#map("<F5>")


" Deoplete
" https://github.com/Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1


" Setup airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'


" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="s-<tab>"

" Spelling should be proper
setlocal spell spelllang=en_gb


" Preserve indendation from system clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>


" Fast write and save
noremap <leader>w :w!<CR>
noremap <leader>q :q!<CR>


source $HOME/.config/nvim/config/formatters.vim
source $HOME/.config/nvim/config/go.vim
