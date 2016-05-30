set encoding=utf8
syntax on
colorscheme wombat
"colorscheme twilight256
"colorscheme dracula
set guifont=Monaco\ for\ Powerline\ 11
set number
set noerrorbells
set vb t_vb=
"set background=dark

" code completion
imap ff <C-P>

" save shortcut, ctrl-s
map ss :w<CR>
map sa :wa<CR>
map qq :wq<CR>
map qe :q!<CR>

" code to set custom background color
" different to terminal
highlight NonText ctermbg=234 ctermfg=999

" for dracula: code to set background transparent
"highlight NonText ctermbg=none
"hi Normal ctermbg=none

" backspace issue
set backspace=indent,eol,start

" to set tab spaces

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" to remap esc key to handy shortcut  
inoremap jk <ESC>

" pathogen execute
execute pathogen#infect()

" CtrlP shortcut
:map :dir :CtrlPMRUFiles

" Syntastic shortcut
":map :checker :SyntasticCheck
":map :reset :SyntasticReset
"
"" syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1let g:syntastic_check_on_wq = 1
"let g:syntastic_check_on_w = 1
"
"
"let g:syntastic_error_symbol ="\ue0b0"  
""✖"
let g:syntastic_error_symbol = '❌'
""let g:syntastic_error_symbol = "\u2603"
""let g:syntastic_style_error_symbol = '⁉️'
""let g:syntastic_warning_symbol = '⚠️'
""let g:syntastic_style_warning_symbol = '💩'
"
highlight SyntasticErrorSign ctermfg=black ctermbg=black
"
""highlight link SyntasticErrorSign SignColumn
""highlight link SyntasticWarningSign SignColumn
""highlight link SyntasticStyleErrorSign SignColumn
""highlight link SyntasticStyleWarningSign SignColumn
"
"let g:syntastic_java_checker = 'javac'
let g:syntastic_java_javac_classpath = '/Users/Paddy/.java-checker'
"
"" java auto complete
"
":setlocal omnifunc=javacomplete#Complete 
":setlocal completefunc=javacomplete#CompleteParamsInfo

" everything below is for
" powerline setup

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

"set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

"" Always show statusline
set laststatus=2
"
"" " Use 256 colours (Use this setting only if your terminal supports 256
"" colours)
set t_Co=256
