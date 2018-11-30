" TODO: make all the paths in the script be read from a configuration file
" that is modified by the bootstrap script
let basedir = "$HOME/dotfiles/vim/"

" Leave no backwards meh from vi
set nocompatible

" Basic styling options
syntax enable
filetype plugin on
set nowrap
set hidden
set number
set relativenumber

au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber

let g:netrw_liststyle = 3
let g:netrw_banner = 0
if !exists(":Drawer")
  function s:PrjDraw()
    let g:netrw_winsize = 25
    :Vexplore
    let g:netrw_altv = 1
    let g:netrw_browse_split = 4
  endfunction

  command Drawer call <SID>PrjDraw()
endif

autocmd InsertEnter *.{c,cpp,cs,rs,go} call deoplete#enable()

call plug#begin()
  Plug 'SirVer/ultisnips'
  Plug 'chriskempson/base16-vim'
  Plug 'powerline/powerline'
  Plug 'stevearc/vim-arduino'
  Plug 'cespare/vim-toml'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'prettier/vim-prettier'
  Plug 'Shougo/deoplete.nvim'
  Plug 'Shougo/neoinclude.vim'
  Plug 'zchee/deoplete-clang'

  if executable('go')
    Plug 'zchee/deoplete-go'
    Plug 'fatih/vim-go'
    Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.config/nvim/plugged/gocode/vim/symlink.sh' }
  endif
call plug#end()

let g:airline_theme='angr'
colo ron

" Write the file automatically when running a command such as GoBuild or make
set autowrite

" Make all go's errors a quickfix list
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"

" Lets just complete me and not add some stupid buffers yeah?
set completeopt=menuone

" Change the behavior of the <Enter> key when the popup menu is visible. In that
" case the Enter key will simply select the highlighted menu item, just as <C-Y>
" does.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" GO SYNTAX
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1

" INDENTATION
set ts=4 sts=4 sw=4 expandtab
set autoindent

" Indentation based on filetype
if has("autocmd")
  exec 'source' basedir . "indentation.vim"
endif

" Hightlight long lines
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" SEARCHING
set ignorecase
set smartcase
set hlsearch
set incsearch


" REMAPS
" Remap ; and : for easy command mode shenanigans
nnoremap ; :
nnoremap : ;

" <C-h|j|k|l> to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

noremap <C-n> :cnext<CR>
noremap <C-m> :cprevious<CR>
noremap ,q :cclose<CR>


" PATH
set path=.,,**,
" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>

" AUTOCMD REQUIRED STUFF
if has("autocmd")
  " vim-go specific configuration
  exec 'source' basedir . "vim-go.vim"

  " Change path according to filetype
  exec 'source' basedir . "path.vim"
endif

" Display tab-completion matches in a cool menu thingy
set wildmenu

" Fold by syntax
"set fdm=syntax

" Remap <Space> to toggle folds
nnoremap <Space> za

" Uncomment this to use space to fold under cursor till the end instead of one
" level
"nnoremap <Space> zM:echom foldlevel(line('.'))<CR>

set foldlevel=0

" This requires ctags installed
" Map the command 'MakeTags' to generate the tags file for the project
" ^]  - jump to tag
" g^] - jump to ambiguous tag
" ^t  - jump back to tag stack
command! MakeTags !ctags -R .

" Autocomplete documentation is present in |ins-completion|
" Good little things to remember:
" ^n         - display all autocomplete options and scroll down the options list
"              (^p to go back in the options)
" ^x[option] - autocomplete options are based on selective things, such as:
"              ^n - complete from this file only
"              ^f - complete by filenames only
"              ^j - complete by tags

" Snippets
execute 'nnoremap' ',go' ":-1read " . basedir . "snippets/go/skele.go<CR>A"
execute 'nnoremap' ',iferr' ":-1read " . basedir . "snippets/go/iferr.go<CR>jA"
execute 'nnoremap' ',sh' ":-1read " . basedir . "snippets/skele.sh<CR>2jA"
execute 'nnoremap' ',py' ":-1read " . basedir . "snippets/skele.py<CR>4jA"
