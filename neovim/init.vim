filetype off

call plug#begin('~/.config/nvim/bundle')

" Plugins
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFind' }
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'derekwyatt/vim-scala'
Plug 'ensime/ensime-vim'
Plug 'elmcast/elm-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


call plug#end()

" Standard config 
filetype plugin indent on
syntax on

" Use , instead of \ as the leader key
let mapleader = ","
let g:mapleader = ","

" Magic: type jk fast to escape insert mode 
imap jk <ESC>l

" Search 
set hlsearch " highlight search
set ignorecase 
set smartcase " capitals in searches make them case sensitive
set showmatch " brackets
set autowrite

" Other useful stuff:
set mat=2 " seconds of blinking when matching parentheses

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

" Vim-go
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Ensime
autocmd BufWritePost *.scala silent :EnTypeCheck
nnoremap <localleader>t :EnTypeCheck<CR>
au FileType scala nnoremap <localleader>df :EnDeclaration<CR>



