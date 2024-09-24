""" GENERAL SETTINGS
set encoding=utf8
set t_Co=256
syntax on
set number
set relativenumber
let mapleader=" "
if !&diff
  tmap kj <C-w>N
endif
set splitright
set background=dark
vmap jk <ESC>
inoremap jk <ESC>
set noerrorbells
set vb t_vb=
set timeoutlen=400 ttimeoutlen=0

""" CRONTAB FILE COMPATIBILITY
set backupskip=/tmp/*,/private/tmp/*"

""" BUFFER NAVIGATION
nmap <silent> bd :bd<cr>
nmap <silent> bn :bn<cr>
nmap <silent> bp :bp<cr>

""" new file in current buffer directory
map new :e %:h/

""" vim-test
""" TestNearest TestFile TestSuite TestLast TestVisit
map test :TestNearest<CR>

"" llm
command! -nargs=1 Llm vert terminal ollama run qwen2.5:3b <q-args>

""" TEXTFILE SPELL CHECK
map :spl :set spell spelllang=en_us
map :splr :hi SpellBad ctermfg=218 <bar> ::hi SpellLocal ctermfg=218 <bar> set spell spelllang=en_us
map :spls :set nospell


""" DISABLE ARROW KEYS
for prefix in ['n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor


""" HIGHLIGHT TAB CHARACTERS
set list
set listchars=tab:>-


""" INDENTATION
filetype plugin on
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4


""" SET FILE TYPES FOR SPECIFIC EXTENSIONS
au BufNewFile,BufRead *.pug set filetype=pug
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.py set
      \ tabstop=4
      \ softtabstop=4
      \ shiftwidth=4
"      \ textwidth=88
      \ expandtab
      \ autoindent
      \ fileformat=unix


""" SET INDENTATION FOR SPECIFIC FILE TYPES
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType pug setlocal tabstop=2 shiftwidth=2 softtabstop=2


""" AUTO COMPLETE
autocmd FileType * call SetAutoComplete()

function SetAutoComplete()
  if &ft =~ 'markdown\|text'
    imap vv <C-x><C-k>
    set dictionary+=~/.vim/dict/google-words.txt
  else
    set omnifunc=syntaxcomplete#Complete
    imap vv  <C-n>
    imap vx  <C-x><C-o>
  endif
endfunction

" allow j and k for navigating dropdown
inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"


""" SAVE SHORTCUTS
map ss :w<CR>
map sa :wa<CR>
map qq :wq<CR>
map qe :q!<CR>


""" ALLOW BACKSPACE
set backspace=indent,eol,start


""" COLORSCHEMES
"colorscheme wombat
"colorscheme gruvbox
"colorscheme twilight256
"colorscheme dracula
"colorscheme palenight
"colorscheme nord
"colorscheme onedark
"colorscheme seoul256
"set termguicolors
"let ayucolor="mirage"
"colorscheme ayu
colorscheme nord


""" CTAGS
set tags+=.git/tags
" nmap <silent> tt :!ctags -R --tag-relative=no -f ./.git/tags .<CR>


""" FOLDING
function SetupPythonFold()
  set foldmethod=expr
  set foldclose=all
  set foldnestmax=2
  set foldexpr=GetPythonFold(v:lnum)
endfunction




" define plugins
call plug#begin()
  " default plugins, loaded on startup
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'psf/black'
  Plug 'tpope/vim-abolish'
  Plug 'vim-test/vim-test'
call plug#end()

""" isort
map isort :%!isort - <CR>
map :isort :%!isort -

""" autoimport
map autoi :%!autoimport - <CR>
map :autoi :%!autoimport -

map :fmt :%!black -q - \| isort - \| autoimport -


""" FZF SETTINGS
" Initialize configuration dictionary
let g:fzf_vim = {}

map grep :Rg 
map <silent> fzf :Files<CR>
map <silent> fbf :Buffers<CR>
map <silent> faf :Buffers<CR>
map <silent> fzz :call fzf#run({"sink":"e", "down": "50%"})<CR>
""" generate ctags while excluding based on gitignore
let g:fzf_vim.tags_command = 'ctags -R -f ./tags $((git ls-files --ignored --exclude-standard -o | sed "s/^/--exclude=/g") || echo "")'
'
" map <silent> ffa " :call fzf#run({"dir": "~/", "sink":"e", "down": "50%"})<CR>
" map <silent> ffb :call fzf#run({"source": map(filter(range(0,bufnr('$')), 'buflisted(v:val)'), 'v:val . " " . bufname(v:val)'), "sink":"e", "down": "50%"})<CR>


""" CTRLP SETTINGS
let g:ctrlp_map = ''
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>m :CtrlPMRU<cr>


""" TAGBAR SETTINGS
nmap <leader>tb :TagbarToggle<CR>




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
  let s .= '%=' . strftime('%k:%M') . ' ' . '%#TabLineEnd#%999X buffers '

  " return completed buffer bar
  return s
endfunction

"""" TAB BAR AND STATUS LINE THEME """"
" Tab and Status Line Theme
" basic theme
function! TabStatusThemeSimple()
  " status line INSERT etc. color
  let g:statusnormal = 245
  let g:statusvisual = 13
  let g:statusinsert = 10
  let g:statusother = 4
  exe 'hi! StatusLine ctermfg='.g:statusnormal
  hi User1 ctermbg=240
  " buffer tab
  hi TabLineFill cterm=none ctermfg=245 ctermbg=239  " clock area
  hi TabLine cterm=none ctermfg=245 ctermbg=239  " non-active tab
  hi TabLineSel cterm=bold ctermfg=236 ctermbg=12  " active tab
  hi TabLineEnd cterm=bold ctermfg=245 ctermbg=237  " buffers part
endfunction

"""" Sets up Tab Bar parameters """"
function! InitTabBar()
    " enable tab bar
    set showtabline=2

    " set tab bar
    set tabline=%!MyTabLine()

    " set tab bar theme
    call TabStatusThemeSimple()

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
    exe 'hi! StatusLine ctermfg='.g:statusnormal
  elseif (mode() =~# '\v(v|V|)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg='.g:statusvisual
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg='.g:statusinsert
  else
    exe 'hi! StatusLine ctermfg='.g:statusother
  endif
  return ''
endfunction

"""" SPEED UP COLOR CHANGE """"
" custom commands to force quicker color change
" vmap <script> <ESC> <ESC><SID>ChangeStatuslineColor
" map <script> v v<SID>ChangeStatuslineColor
" au InsertLeave * call ChangeStatuslineColor()

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
set statusline+=%0*\ %3p%%\ ln\ %l:\ %3c\                 " Rownumber/total (%)
