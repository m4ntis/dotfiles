" TODO: make all the paths in the script be read from a configuration file
" that is modified by the bootstrap script
let basedir = "$HOME/dotfiles/vim/"

" Leave no backwards meh from vi
set nocompatible

" Basic styling options
syntax enable
filetype plugin on
set number
set nowrap

" Make the status line display the name and stuffs
set statusline=%F


" INDENTATION
set ts=4 sts=4 sw=4 expandtab
set autoindent

" Indentation based on filetype
if has("autocmd")
  exec 'source' basedir . "indentation.vim"
endif


" SEARCHING
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


" PATH
set path=.,,**,

" Change path according to filetype
if has("autocmd")
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
execute 'nnoremap' ',go' ":-1read " . basedir . "snippets/go/skele.go<CR>wa"
execute 'nnoremap' ',iferr' ":-1read " . basedir . "snippets/go/iferr.go<CR>jA"
execute 'nnoremap' ',sh' ":-1read " . basedir . "snippets/skele.sh<CR>2jA"
execute 'nnoremap' ',py' ":-1read " . basedir . "snippets/skele.py<CR>4jA"
