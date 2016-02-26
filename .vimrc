syntax on
colorscheme wombat
set number
highlight NonText ctermbg=234 ctermfg=999:wq

" to set tab spaces

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" to remap esc key
inoremap jk <ESC>

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

"
"
"" Always show statusline
set laststatus=2
"
"" " Use 256 colours (Use this setting only if your terminal supports 256
"" colours)
set t_Co=256
