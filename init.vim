call plug#begin('~/.vim/plugged')

" Install NERDTree
Plug 'preservim/nerdtree'

" Install Google codefmt
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'github/copilot.vim'

" Install github copilot
Plug 'github/copilot.vim'

call plug#end()

" NERDTree setup and other configurations
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if exists(":NERDTree") | NERDTree | endif

" Powerline configuration
set rtp+=/usr/local/lib/python3.11/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256-color (important for Powerline)
set t_Co=256
" Use fancy symbols
let g:Powerline_symbols = 'fancy'
" Use the default theme
let g:Powerline_theme = 'default'
" Use the default colorscheme
let g:Powerline_colorscheme = 'default'
" Use the default separator
let g:Powerline_separators = 'default'
" Use the default mode indicator
let g:Powerline_mode_indicator = 'default'

" Set the path to the Python interpreter from the virtual environment
let g:python3_host_prog = '/usr/src/app/.venv/bin/python'

set number
set relativenumber
set tabstop=4

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,typescript,arduino AutoFormatBuffer clang-format
  autocmd FileType clojure AutoFormatBuffer cljstyle
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType elixir,eelixir,heex AutoFormatBuffer mixformat
  autocmd FileType fish AutoFormatBuffer fish_indent
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType haskell AutoFormatBuffer ormolu
  " Alternative for web languages: prettier
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType jsonnet AutoFormatBuffer jsonnetfmt
  autocmd FileType julia AutoFormatBuffer JuliaFormatter
  autocmd FileType kotlin AutoFormatBuffer ktfmt
  autocmd FileType lua AutoFormatBuffer luaformatterfiveone
  autocmd FileType markdown AutoFormatBuffer prettier
  autocmd FileType ocaml AutoFormatBuffer ocamlformat
  autocmd FileType python AutoFormatBuffer black
  " autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType ruby AutoFormatBuffer rubocop
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType swift AutoFormatBuffer swift-format
  autocmd FileType vue AutoFormatBuffer prettier
augroup END