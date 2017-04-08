
set encoding=utf8
set t_Co=256
syntax on
" FAVOURITE COLORSCHEMES
"colorscheme wombat
colorscheme gruvbox
"colorscheme twilight256
"colorscheme dracula
" change highlight color for dracula
hi Visual ctermfg=248
" set splits on right side, mainly for NERDTree
set splitright

" FOR SOLARIZED
" First, set terminal theme to
" solarized
" Then enable:
" or light
" then add the following
" below pathogen
" colorscheme solarized
" END SOLARIZED
set background=dark
set number
set relativenumber
" NERDTree shortcut
map nd :NERDTree<CR>
map :spl :set spell spelllang=en_us

" option to auto load NERDTree
" au VimEnter *  NERDTree
for prefix in ['n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

set number
set noerrorbells
set vb t_vb=

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
imap vv  <C-P>

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

"""""""""""""""""""" Plugins

" CtrlP shortcut
:map :dir :CtrlPMRUFiles

" FZF install and shortcut
set rtp+=~/.fzf

:map :fzf :FZF
map fdf :FZF<CR>


" custom tab bar function to show
" buffers instead of tabs
" ref: http://vimdoc.sourceforge.net/htmldoc/tabpage.html
function! MyTabLine()
  let buflist = filter(range(1,bufnr('$')),'buflisted(v:val) && "quickfix" !=? getbufvar(v:val, "&buftype")')
  let s = 'Buffers  '
  for i in buflist
    " select the highlighting
    if i == bufnr('%')
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' ' . i . '. ' . fnamemodify(bufname(i) , ':f') . ' '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
    let s .= '%=' . strftime('%k:%M') . ' | ' . '%#TabLine#%999Xbuffers'

  return s
endfunction

" enable tab bar
set showtabline=2

" set tab bar
set tabline=%!MyTabLine()

" refresh tab bar to keep time
" current
autocmd CursorHold * call Timer()
function! Timer()
  call feedkeys("f\e")
  set tabline=%!MyTabLine()              
endfunction



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


set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ [nogit]                        " Git Branch name
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
