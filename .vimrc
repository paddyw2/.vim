set encoding=utf8
set t_Co=256
syntax on
set number
set relativenumber

" cron compatibility
set backupskip=/tmp/*,/private/tmp/*"

" ctags
set tags+=.git/tags
nmap <silent> tt :!ctags -R --tag-relative=no -f ./.git/tags .<CR>

" change highlight color for dracula
"hi Visual ctermfg=248
" set splits on right side, mainly for NERDTree
let mapleader=" "
tmap kj <C-w>N
set splitright

" to remap esc key
vmap jk <ESC>
inoremap jk <ESC>

set background=dark

autocmd FileType python :call SetupPythonFold()

function SetupPythonFold()
  " folding
  set foldmethod=expr
  set foldclose=all
  set foldnestmax=2
  set foldexpr=GetPythonFold(v:lnum)
endfunction

function GetPythonFold(lnum)
  let n = a:lnum
  while n > 0
    let currline = getline(n)
    let prevline = getline(n-1)
    let nextline = getline(n+1)
    if nextline =~ '^\s*def ' && currline =~ '^\s*$'
      return '0'
    elseif prevline =~ '^\s*def '
      return '1'
    endif
    let n -= 1
  endwhile
  return '0'
endfunction

" file explorerlet
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

"nmap ff :Vexplore<CR>
nmap <silent> bd :bd<cr>
nmap <silent> bn :bn<cr>
nmap <silent> bp :bp<cr>
let g:ctrlp_map = ''
nmap <c-b> :CtrlPBuffer<cr>
nmap <c-m> :CtrlPMRU<cr>


" spell check shortcut
map :spl :set spell spelllang=en_us
map :splr :hi SpellBad ctermfg=218 <bar> ::hi SpellLocal ctermfg=218 <bar> set spell spelllang=en_us
map :spls :set nospell


for prefix in ['n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

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

" set pug filetype
au BufNewFile,BufRead *.pug set filetype=pug
au BufNewFile,BufRead *.ejs set filetype=html

" change indent for ruby, python, and vim
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType vim setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2
"autocmd FileType python setlocal tabstop=2 shiftwidth=2
autocmd FileType pug setlocal tabstop=2 shiftwidth=2

" code completion
imap vv  <C-n>

autocmd FileType text imap vv <C-x><C-k>
autocmd FileType markdown imap vv <C-x><C-k>

inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"
"set dictionary+=~/.vim/dict/google-words.txt

nmap bp :bp<CR>
nmap bn :bn<CR>
" buffer navigation

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



""" FZF NOT CURRENTLY USED
" FZF install and shortcut
"set rtp+=~/.fzf
map <silent> fzf :call fzf#run({"sink":"e", "down": "50%"})<CR>
map <silent> ffa :call fzf#run({"dir": "~/", "sink":"e", "down": "50%"})<CR>
map <silent> ffb :call fzf#run({"source": map(filter(range(0,bufnr('$')), 'buflisted(v:val)'), 'v:val . " " . bufname(v:val)'), "sink":"e", "down": "50%"})<CR>

":map :fzf :FZF
"map fdf :FZF<CR>


"""" BUFFER TAB CUSTOMIZATION """"

" custom tab bar function to show
" buffers instead of tabs
" ref: http://vimdoc.sourceforge.net/htmldoc/tabpage.html
function! MyTabLine()
  let buflist = filter(range(1,bufnr('$')),'buflisted(v:val) && "quickfix" !=? getbufvar(v:val, "&buftype")')
  let s = ''
  for i in buflist
    " if current buffer, set to current
    " tab
    if i == bufnr('%')
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " get buffer file name
    let filename = fnamemodify(bufname(i) , ':t')
    if filename == ''
      let filename = '[No Name]'
    endif

    " put file name and buffer number together
    " and concatentate with previous buffers
    let s .= ' ' . i . '. ' . filename . ' '
  endfor

  " reset to main tab fill after buffers
  " are displayed
  let s .= '%#TabLineFill#%T'

  " right-align the buffer text and clock 
  let s .= '%=' . '%#TabLineTime#%999X ' . strftime('%k:%M') . ' ' . '%#TabLineEnd#%999X buffers '

  " return completed buffer bar
  return s
endfunction

"""" TAB BAR AND STATUS LINE THEME """"
" Tab and Status Line Theme
" basic theme
function! TabStatusThemeSimple()
  " status line
  let g:statusnormal = 214
  let g:statusvisual = 005
  let g:statusinsert = 039
  let g:statusother = 008
  exe 'hi! StatusLine ctermfg='.g:statusnormal
  hi User1 ctermbg=240
  " buffer tab
  hi TabLineFill cterm=none ctermfg=223 ctermbg=237
  hi TabLine cterm=none ctermfg=223 ctermbg=237
  hi TabLineSel cterm=bold ctermfg=236 ctermbg=214
  hi TabLineTime cterm=none ctermfg=223 ctermbg=237
  hi TabLineEnd cterm=bold ctermfg=0 ctermbg=175
endfunction

function! TabStatusThemeMinimal()
  " status line
  let g:statusnormal = 008
  let g:statusvisual = 005
  let g:statusinsert = 039
  let g:statusother = 008
  exe 'hi! StatusLine ctermfg='.g:statusnormal
  hi User1 ctermbg=240
  " buffer tab
  hi TabLineFill cterm=none ctermfg=236 ctermbg=237
  hi TabLine cterm=none ctermfg=244 ctermbg=237
  hi TabLineSel cterm=bold ctermfg=236 ctermbg=008
  hi TabLineTime cterm=none ctermfg=236 ctermbg=240
  hi TabLineEnd cterm=bold ctermfg=0 ctermbg=175
endfunction


function! TabStatusThemeGruv()
  " status line
  let g:statusnormal = 240
  let g:statusnormalbg = 0
  let g:statusvisual = 175
  let g:statusvisualbg = 0
  let g:statusinsert = 109
  let g:statusinsertbg = 0
  let g:statusother = 008
  let g:statusotherbg = 0

  exe 'hi! StatusLine ctermfg='.g:statusnormal.' ctermbg='.g:statusnormalbg
  hi User1 ctermbg=242 ctermfg=235
  " buffer tab
  hi TabLineFill cterm=none ctermfg=236 ctermbg=237
  hi TabLine cterm=none ctermfg=235 ctermbg=240
  hi TabLineSel cterm=bold ctermfg=235 ctermbg=109
  hi TabLineTime cterm=none ctermfg=235 ctermbg=241
  hi TabLineEnd cterm=bold ctermfg=235 ctermbg=108
endfunction

"""" Sets up Tab Bar parameters """"
function! InitTabBar()
    " enable tab bar
    set showtabline=2

    " set tab bar
    set tabline=%!MyTabLine()

    " set tab bar theme
    call TabStatusThemeGruv()

    " refresh tab bar to keep time
    " current
    autocmd CursorHold * call Timer()
endfunction

call InitTabBar()

"""" Tab Bar Refresh (for clock) """"
function! Timer()
  call feedkeys("f\e")
  set tabline=%!MyTabLine()              
endfunction


"""" STATUS LINE """"
" Most taken from: https://gabri.me/blog/diy-vim-statusline
" Note that the %1 values in set statusline+= refer to color
" values defined in the theme function. These work as follows:
" User1 -> %1
" User2 -> %2
" etc.
" They must follow this convention, and be called before the
" status bar is configured

"""" MODE DICTIONARY """"
let g:currentmode={
    \ 'n'  : 'NORMAL ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'VISUAL ',
    \ 'V'  : 'V·Line ',
    \ '' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'INSERT ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
  \ 't'  : 'TERMINAL '}


"""" CHANGE STATUS COLOR DEPENDING ON MODE """"
" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg='.g:statusnormal.' ctermbg='.g:statusnormalbg
  elseif (mode() =~# '\v(v|V)' || mode() =~# '\v(v|)' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg='.g:statusvisual.' ctermbg='.g:statusvisualbg
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg='.g:statusinsert.' ctermbg='.g:statusinsertbg
  else
    exe 'hi! StatusLine ctermfg='.g:statusother.' ctermbg='.g:statusotherbg
  endif
  return ''
endfunction

"""" SPEED UP COLOR CHANGE """"
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

" Check if current file is read only
function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

" Build status line
set laststatus=2
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%9*\ %y\                                 " FileType
set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%1*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\ %3p%%\ \ %l:\ %3c\                 " Rownumber/total (%)


" FAVOURITE COLORSCHEMES
"colorscheme wombat
"colorscheme gruvbox
"colorscheme twilight256
"colorscheme dracula
set background=dark
"colorscheme palenight
colorscheme onedark
"colorscheme nord
"set runtimepath^=~/.vim/bundle/*

call plug#begin()
  Plug 'dense-analysis/ale'
  Plug 'ycm-core/YouCompleteMe'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'ternjs/tern_for_vim'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-dispatch'
call plug#end()

"" YCM config
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_auto_trigger=0
let g:syntastic_error_symbol= '➜'
let g:syntastic_warning_symbol= '➜'
let g:ycm_autoclose_preview_window_after_completion = 1

"" AIRLINE config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'

"" ALE config 
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ }

let g:ale_linters = {
  \ 'haskell': ['hlint', 'hdevtools', 'hfmt'],
  \ 'python': ['mypy', 'pycodestyle'],
  \ 'typescript': ['eslint', 'tslint', 'tsserver', 'typecheck', 'xo'],
  \ 'javascript': ['eslint', 'ecs', 'flow', 'flow_ls', 'jscs', 'jshint', 'standard', 'tsserver', 'xo'],
  \ 'cs': ['csc', 'msc', 'mcsc']
  \ }
let g:ale_sign_error = '➜'
let g:ale_sign_warning = '➜'
