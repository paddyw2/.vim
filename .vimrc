" GENERAL SETTINGS
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


""" SET INDENTATION FOR SPECIFIC FILE TYPES
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
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
    imap vo  <C-x><C-o>
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
colorscheme despacio
"colorscheme twilight256
"colorscheme dracula
"colorscheme palenight
"colorscheme nord
"colorscheme onedark
"colorscheme seoul256

function CustomizeSyntaxCheckerColors()
  if g:colors_name == 'despacio'
    hi Error ctermbg=9 ctermfg=234
    hi SpellBad ctermbg=234 ctermfg=9

    hi Todo ctermbg=214 ctermfg=234
    hi SpellCap ctermbg=234 ctermfg=214
  endif
endfunction

call CustomizeSyntaxCheckerColors()

""" CTAGS
set tags+=.git/tags
nmap <silent> tt :!ctags -R --tag-relative=no -f ./.git/tags .<CR>


""" FOLDING
function SetupPythonFold()
  set foldmethod=expr
  set foldclose=all
  set foldnestmax=2
  set foldexpr=GetPythonFold(v:lnum)
endfunction

" ensures folds only occur from def to the next def
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


""" VIM PLUG SETTINGS
" command to allow heavyweight plugins to be lazy loaded
map <silent> <leader>ide <Plug>EnableIDE
map <silent> <leader>goyo <Plug>EnableGoyo

" define plugins
call plug#begin()
  " default plugins, loaded on startup
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  " writing plugins, loaded on EnableGoyo
  Plug 'junegunn/goyo.vim', {'on': '<Plug>EnableGoyo'}
  Plug 'junegunn/limelight.vim', {'on': '<Plug>EnableGoyo'}
"  " IDE plugins, loaded on EnableIDE
  Plug 'dense-analysis/ale', {'on': '<Plug>EnableIDE'}
  Plug 'ycm-core/YouCompleteMe', {'on': '<Plug>EnableIDE'}
  Plug 'ternjs/tern_for_vim', {'on': '<Plug>EnableIDE'}
  Plug 'tpope/vim-fugitive', {'on': '<Plug>EnableIDE'}
  Plug 'airblade/vim-gitgutter', {'on': '<Plug>EnableIDE'}
  Plug 'ctrlpvim/ctrlp.vim', {'on': '<Plug>EnableIDE'}
  Plug 'tpope/vim-dispatch', {'on': '<Plug>EnableIDE'}
  Plug 'majutsushi/tagbar', {'on': '<Plug>EnableIDE'}
  Plug 'tpope/vim-eunuch', {'on': '<Plug>EnableIDE'}
call plug#end()


""" FZF SETTINGS
map <silent> fzf :call fzf#run({"sink":"e", "down": "50%"})<CR>
map <silent> ffa :call fzf#run({"dir": "~/", "sink":"e", "down": "50%"})<CR>
map <silent> ffb :call fzf#run({"source": map(filter(range(0,bufnr('$')), 'buflisted(v:val)'), 'v:val . " " . bufname(v:val)'), "sink":"e", "down": "50%"})<CR>


""" CTRLP SETTINGS
let g:ctrlp_map = ''
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>m :CtrlPMRU<cr>


""" TAGBAR SETTINGS
nmap <leader>tb :TagbarToggle<CR>


""" GOYO SETTINGS
nmap <leader>gy :call ToggleGoyo()<CR>
let g:goyo_enabled = 0

function ToggleGoyo()
  if g:goyo_enabled
    let g:goyo_enabled = 0
    exe 'Goyo!'
    exe 'Limelight!'
    let g:goyo_enabled = 0
    exe 'colorscheme '. g:goyo_old_colorscheme
  else
    let g:goyo_enabled = 1
    let g:goyo_old_colorscheme = g:colors_name
    colorscheme seoul256
    exe 'Goyo'
    exe 'Limelight'
  endif
endfunction


""" YOUCOMPLETEME SETTINGS
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_auto_trigger=0
let g:syntastic_error_symbol= '➜'
let g:syntastic_warning_symbol= '➜'
let g:ycm_autoclose_preview_window_after_completion = 1


""" AIRLINE SETTINGS
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_grayscale'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1



""" ALE SETTINGS
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'haskell': ['hlint', 'hdevtools', 'hfmt'],
  \ 'python': ['mypy', 'pycodestyle', 'pylint'],
  \ 'typescript': ['eslint', 'tslint', 'tsserver', 'typecheck', 'xo'],
  \ 'javascript': ['eslint', 'ecs', 'flow', 'flow_ls', 'jscs', 'jshint', 'standard', 'tsserver', 'xo'],
  \ 'cs': ['csc', 'msc', 'mcsc']
  \ }
let g:ale_sign_error = '➜'
let g:ale_sign_warning = '➜'
