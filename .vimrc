syntax enable
"colorscheme wombat
"colorscheme twilight256
"colorscheme dracula
set background=dark
colorscheme solarized
" change highlight color for dracula
hi Visual ctermfg=248
" set splits on right side, mainly for NERDTree
set splitright


" NERDTree shortcut
map nd :NERDTree<CR>
:map :spl :set spell spelllang=en_us

" option to auto load NERDTree
" au VimEnter *  NERDTree
for prefix in ['n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

" customize tab bar colors
hi TabLineFill ctermfg=234


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
filetype plugin on
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
imap vv <C-P>

" save shortcuts
map ss :w<CR>
map sa :wa<CR>
map qq :wq<CR>
map qe :q!<CR>

" code to set custom background color
" different to terminal
"highlight NonText ctermbg=234 ctermfg=999

" for dracula: code to set background transparent
"highlight NonText ctermbg=none
"hi Normal ctermbg=none

" backspace issue
set backspace=indent,eol,start


" to remap esc key to handy shortcut  
vmap jk <ESC>
inoremap jk <ESC>

"""""""""""""""""""" Plugins
" pathogen execute
execute pathogen#infect()

" CtrlP shortcut
:map :dir :CtrlPMRUFiles

" FZF install and shortcut
set rtp+=~/.fzf

:map :fzf :FZF
map fdf :FZF<CR>

" for built in autocomplete
" python
" let g:pydiction_location = '/Users/paddy/.vim/bundle/pydiction/complete-dict'

""✖"
" let g:syntastic_error_symbol = '❌'
""let g:syntastic_error_symbol = "\u2603"
""let g:syntastic_style_error_symbol = '⁉️'
""let g:syntastic_warning_symbol = '⚠️'
""let g:syntastic_style_warning_symbol = '💩'
"
" highlight SyntasticErrorSign ctermfg=black ctermbg=black
" let g:syntastic_java_javac_classpath = '/Users/Paddy/.java-checker'

"""""""""""""" personal status line
set laststatus=2

set statusline+=%b,0x%-8B\                   " current char

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


" set custom color for nomal mode on startup
exe 'hi! StatusLine ctermfg=249'
" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=249'
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
vmap <script> <ESC> <ESC><SID>ChangeStatuslineColor
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
"set statusline+=%{SyntasticStatuslineFlag()}             " Syntastic errors
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
