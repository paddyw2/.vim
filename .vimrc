set encoding=utf8
set t_Co=256
syntax on
"colorscheme wombat
"colorscheme twilight256
colorscheme dracula
" change highlight color for dracula
hi Visual ctermfg=248
" set splits on right side, mainly for NERDTree
set splitright

" NERDTree shortcut
map nd :NERDTree<CR>

" option to auto load NERDTree
" au VimEnter *  NERDTree
for prefix in ['n', 'v', 'i']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

if has('gui_running')
    set guifont=Knack\ Regular\ Nerd\ Font\ Plus\ Font\ Awesome\ Mono:h12
    colorscheme material-theme
endif
set number
set noerrorbells
set vb t_vb=
"set background=dark

" set key delay timeout
set timeoutlen=400 ttimeoutlen=0

" show tabs as characters
set list
set listchars=tab:>-
" set tab scheme
" to set tab spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" change indent for ruby
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType vim setlocal tabstop=2 shiftwidth=2
autocmd FileType python setlocal tabstop=2 shiftwidth=2

" code completion
imap ff <C-P>

" save shortcuts
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


" to remap esc key to handy shortcut  
vmap jk <ESC>
inoremap jk <ESC>

" pathogen execute
execute pathogen#infect()

" CtrlP shortcut
:map :dir :CtrlPMRUFiles

" FZF install and shortcut
set rtp+=~/.fzf

:map :fzf :FZF
map fdf :FZF<CR>

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

"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
"
"let g:Powerline_symbols = 'fancy'
"set encoding=utf-8
"set t_Co=256
"set fillchars+=stl:\ ,stlnc:\
"set termencoding=utf-8
"
""" Always show statusline
"set laststatus=2
""
""" Use 256 colours (Use this setting only if your terminal supports 256
""" colours)
" set t_Co=256




"" personal status line
set laststatus=2

" timpopes set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
"
"set statusline=   " clear the statusline for when vimrc is reloaded
"set statusline+=%-3.3n\                      " buer number
"set statusline+=%f\                          " file name
"set statusline+=%h%m%r%w                     " flags
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
"set statusline+=%{&fileformat}]              " file format
"set statusline+=%{PrintMode()}                    " file format
"set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " onlyset

"function! PrintMode()
"  if mode() == 'v'
"    hi StatusLine term=reverse ctermfg=0 ctermbg=90
"    return  Visual"
"  elseif mode() == i"
"    hi StatusLine term=reverse ctermfg=0 ctermbg=75
"    return  Insert"
"  else
"    exe 'hi! statusLine ctermfg=230 ctermbg=238'
"    return  Normal"
"  endif
"endfunction
"
"nnoremap <script> v v<SID>PrintMode
"nnoremap <script> <ESC> <ESC><SID>PrintMode


" Statusline

let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
  \ 't'  : 'Terminal '}

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=008'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=005'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=039'
  else
    exe 'hi! StatusLine ctermfg=006'
  endif
  return ''
endfunction

" custom commands to force quicker color change
map <silent> <ESC> :call ChangeStatuslineColor()<CR>
map <script> v v<SID>ChangeStatuslineColor
au InsertLeave * call ChangeStatuslineColor()

" Find out current buffer's size and output it.
function! FileSize()
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif

    if bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return mbytes . 'MB '
    elseif (exists('kbytes'))
        return kbytes . 'KB '
    else
        return bytes . 'B '
    endif
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.fugitive#head()
  else
    return ''
endfunction

set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %{GitInfo()}                        " Git Branch name
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}             " Syntastic errors
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\ %3p%%\ \ %l:\ %3c\                 " Rownumber/total (%)

hi User1 ctermfg=007
hi User2 ctermfg=008
hi User3 ctermfg=008
hi User4 ctermfg=008
hi User5 ctermfg=008
hi User7 ctermfg=008
hi User8 ctermfg=008
hi User9 ctermfg=007
