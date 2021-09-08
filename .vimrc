call plug#begin('~/.vim/plugged')

Plug 'terroo/vim-simple-emoji'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'matsuuu/pinkmare'
Plug 'ycm-core/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/lh-tags'
Plug 'LucHermitte/lh-dev'
Plug 'LucHermitte/lh-style'
Plug 'LucHermitte/lh-brackets'
Plug 'LucHermitte/vim-refactor'

call plug#end()

let g:pinkmare_transparent_background = 1

colorscheme pinkmare
syntax on
set number
set relativenumber
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noswapfile
set noshowmode
set mouse=a
set title
set cursorline
set encoding=utf-8
set hls

hi! MatchParen cterm=NONE,bold gui=NONE,bold guibg=#f7c095 guifg=NONE
map <C-n> :NERDTreeToggle<CR>

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
set completeopt-=preview
let g:ycm_show_diagnostics_ui = 0

" hi Normal guibg=NONE ctermbg=NONE

let g:ycm_key_list_select_completion = ["<C-n>"]
let g:ycm_key_list_previous_completion = ["<C-p>"]
let g:SuperTabDefaultCompletionType = "<C-n>"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

